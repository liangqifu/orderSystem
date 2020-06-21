package com.qst.goldenarches.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSON;
import com.qst.goldenarches.dao.CategoryMapper;
import com.qst.goldenarches.dao.OrderDetailMapper;
import com.qst.goldenarches.dao.OrderMasterMapper;
import com.qst.goldenarches.dao.OrderPrinterLogMapper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.pojo.Printer;
import com.qst.goldenarches.pojo.PrinterObj;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.print.OrderDetailInfo;
import com.qst.goldenarches.print.OrderInfo;
import com.qst.goldenarches.print.PrinterService;
import com.qst.goldenarches.print.Ticket;
import com.qst.goldenarches.print.TicketPC;
import com.qst.goldenarches.service.OrderPrinterService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.utils.DateUtils;
import com.qst.goldenarches.utils.DigitalUtil;
import com.qst.goldenarches.utils.ResourceUtils;
import com.qst.goldenarches.vo.OrderNeedServiceVo;
@Service
public class OrderPrinterServiceImpl implements OrderPrinterService {
	private static Logger logger = LogManager.getLogger(OrderPrinterServiceImpl.class);
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	@Autowired
	private OrderMasterMapper orderMasterMapper;
	@Autowired
	private OrderPrinterLogMapper orderPrinterLogMapper;
	@Autowired
	private PrinterService printerService;
	@Autowired
	private SettingService settingService;
	@Override
	public void handelOrderPrinter(OrderPrinterLog orderPrinter) throws Exception{
		try {
			logger.info(JSON.toJSONString(orderPrinter));
			Setting setting =settingService.getSettingInfo();
			OrderMaster orderMaster = orderMasterMapper.selectByPrimaryKey(orderPrinter.getOrderId());
			List<OrderDetail> orderDetails = null;
			//1菜品打印 2酒水打印 3服务打印 4通知付款打印
			if("1".equals(orderPrinter.getPinterType())) {//菜品打印
				OrderRound orderRound =JSON.parseObject(orderPrinter.getContent(), OrderRound.class);
				orderDetails = orderRound.getOrderDetails();
			}else if("2".equals(orderPrinter.getPinterType())) {//2酒水打印
				orderDetails =JSON.parseArray(orderPrinter.getContent(), OrderDetail.class);
			}else if("3".equals(orderPrinter.getPinterType())) {//3服务打印 
				OrderNeedServiceVo needServiceVo = JSON.parseObject(orderPrinter.getContent(), OrderNeedServiceVo.class);
				orderDetails = needServiceVo.getNeedServiceDetails();
			}else if("4".equals(orderPrinter.getPinterType())) {//4通知付款打印
				List<Ticket> tickets = getPrintTickets(orderMaster, null, setting, orderPrinter);
				//调打印机开始打印
				printerService.printer(tickets);
				//更新打印日志信息
				orderPrinter.setStatus("1");
				orderPrinter.setMsg("打印成功");
				orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
			}
			
			if(!CollectionUtils.isEmpty(orderDetails)) {
				PrinterObj printerObj = getPrinterList(orderDetails, orderPrinter);
				if(printerObj.isFlag()) {
					Map<String, List<OrderDetail>> printerMap = printerObj.getPrinterMap();
					if(!CollectionUtils.isEmpty(printerMap)) {
						List<Ticket> tickets = getPrintTickets(orderMaster, printerMap,setting,orderPrinter);
						//调打印机开始打印
						printerService.printer(tickets);
						//更新打印日志信息
						orderPrinter.setStatus("1");
						orderPrinter.setMsg("打印成功");
						orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
					}
					
				}else {
					orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
				}
			}else {
				if("3".equals(orderPrinter.getPinterType())) {//3服务打印 
					List<Ticket> tickets = getPrintTickets(orderMaster, null, setting, orderPrinter);
					//调打印机开始打印
					printerService.printer(tickets);
					//更新打印日志信息
					orderPrinter.setStatus("1");
					orderPrinter.setMsg("打印成功");
					orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
				}
			}
		} catch (Exception e) {
			logger.error("handelOrderPrinter error",e);
		}
		
	}
	@Override
	public void handelPCPayPrinter(OrderPrinterLog orderPrinter) throws Exception{
		OrderMaster orderMaster = orderMasterMapper.selectByPrimaryKey(orderPrinter.getOrderId());
		Setting setting =settingService.getSettingInfo();
		List<TicketPC> tickets = getPrintTicketsPC(orderMaster,setting, orderPrinter);
		//调打印机开始打印
		printerService.printerPC(tickets);
	}
	
	private List<TicketPC> getPrintTicketsPC(OrderMaster orderMaster,Setting setting,OrderPrinterLog orderPrinter){
		List<TicketPC> tickets = new ArrayList<TicketPC>();
		OrderInfo orderInfo = this.getPrintOrderInfo(orderMaster, setting, orderPrinter);
		orderInfo.setDetailInfos(this.getPrintOrderDetailInfo(orderMaster, setting));
		Category category = categoryMapper.getById(41);
		if(category != null) {
			if(category.getPrinter() != null && !org.springframework.util.StringUtils.isEmpty(category.getPrinter().getIp())) {
				TicketPC ticket = new TicketPC(orderInfo,category.getPrinter().getIp(),setting);
				tickets.add(ticket);
			}else {
				logger.error("服务或支付分类未关联打印机");
			}
		}else {
			logger.error("服务或支付分类不存在");
		}
		return tickets;
	}
	
	private List<OrderDetailInfo> getPrintOrderDetailInfo(OrderMaster orderMaster, Setting setting){
		List<OrderDetailInfo> list = new ArrayList<OrderDetailInfo>();
		OrderDetailInfo detailInfo = null;
		if(orderMaster.getAdult()!=null && orderMaster.getAdult().intValue() > 0) {
			detailInfo = new OrderDetailInfo();
			detailInfo.setNumber(orderMaster.getAdult());
			detailInfo.setProductName(ResourceUtils.getValueByLanguage("adult", setting.getLanguage()));
			detailInfo.setPrice(DigitalUtil.scale2(orderMaster.getAdultAmount()));
			list.add(detailInfo);
		}
		if(orderMaster.getChild() != null && orderMaster.getChild().intValue() > 0) {
			detailInfo = new OrderDetailInfo();
			detailInfo.setNumber(orderMaster.getChild());
			detailInfo.setProductName(ResourceUtils.getValueByLanguage("child", setting.getLanguage()));
			
			detailInfo.setPrice(DigitalUtil.scale2(orderMaster.getChildAmount()));
			list.add(detailInfo);
		}
		OrderDetail param = new OrderDetail();
		param.setOrderId(orderMaster.getOrderId());
		param.setDetailType("1");
		param.setState("0");
		List<OrderDetail> details = orderDetailMapper.queryOrderDetail(param);
		if(!CollectionUtils.isEmpty(details)) {
			for (OrderDetail orderDetail : details) {
				detailInfo = new OrderDetailInfo();
				detailInfo.setNumber(orderDetail.getProductNumber());
				detailInfo.setProductName(orderDetail.getProductName());
				detailInfo.setPrice(DigitalUtil.mul(orderDetail.getProductPrice(), new BigDecimal(orderDetail.getProductNumber())));
				list.add(detailInfo);
			}
		}
		return list;
	}
	private List<Ticket> getPrintTickets(OrderMaster orderMaster,Map<String, List<OrderDetail>> printerMap,Setting setting,OrderPrinterLog orderPrinter){
		List<Ticket> tickets = new ArrayList<Ticket>();
		Ticket ticket = null;
		OrderInfo orderInfo = null;
		if(!CollectionUtils.isEmpty(printerMap)) {
			for (Map.Entry<String, List<OrderDetail>> entry : printerMap.entrySet()) {
				String printerIp = entry.getKey();
				List<OrderDetail> printDetails = entry.getValue();
				List<OrderDetailInfo> batchDetailInfos =  new ArrayList<OrderDetailInfo>();
				OrderDetailInfo detailInfo = null;
				for (OrderDetail detail : printDetails) {
					Category category = categoryMapper.getById(detail.getCategoryId());
					//打印类型 0批量 1单个
					if("1".equals(category.getPrintType()) ) {//1单个打印
						orderInfo = this.getPrintOrderInfo(orderMaster, setting, orderPrinter);
						List<OrderDetailInfo> detailInfos =  new ArrayList<OrderDetailInfo>();
						detailInfo =  new OrderDetailInfo();
						detailInfo.setNumber(detail.getProductNumber());
						detailInfo.setProductName(detail.getProductName());
						Product product = detail.getProduct();
						detailInfo.setProductNo(product.getNo());
						detailInfos.add(detailInfo);
						orderInfo.setDetailInfos(detailInfos);
						ticket = new Ticket(orderInfo,printerIp,setting);
						tickets.add(ticket);
					}else {//批量打印
						detailInfo =  new OrderDetailInfo();
						detailInfo.setNumber(detail.getProductNumber());
						detailInfo.setProductName(detail.getProductName());
						Product product = detail.getProduct();
						detailInfo.setProductNo(product.getNo());
						batchDetailInfos.add(detailInfo);
					}
				}
				
				if(!CollectionUtils.isEmpty(batchDetailInfos)) {
					orderInfo = this.getPrintOrderInfo(orderMaster, setting, orderPrinter);
					orderInfo.setDetailInfos(batchDetailInfos);
					ticket = new Ticket(orderInfo,printerIp,setting);
					tickets.add(ticket);
				}
			}
			
		}else {
			orderInfo = this.getPrintOrderInfo(orderMaster, setting, orderPrinter);
			Category category = null;
			if("3".equals(orderPrinter.getPinterType())) { //服务打印
				category = categoryMapper.getById(3);
			} else if("4".equals(orderPrinter.getPinterType())) {//结账打印
				category = categoryMapper.getById(41);
			}
			if(category != null) {
				if(category.getPrinter() != null && !org.springframework.util.StringUtils.isEmpty(category.getPrinter().getIp())) {
					ticket = new Ticket(orderInfo,category.getPrinter().getIp(),setting);
					tickets.add(ticket);
				}else {
					logger.error("服务或支付分类未关联打印机");
				}
			}else {
				logger.error("服务或支付分类不存在");
			}
		}
		
		return tickets;
	}
	
	private OrderInfo getPrintOrderInfo(OrderMaster orderMaster,Setting setting,OrderPrinterLog orderPrinter) {
		OrderInfo orderInfo = new OrderInfo();
		orderInfo.setTotalAmount(orderMaster.getTotalAmount());
		orderInfo.setArea(orderMaster.getArea().getName());
		Date createTime = orderPrinter.getCreateTime();
		String date = createTime !=null? DateUtils.formatDate(createTime, "dd.MM.yyyy") : DateUtils.formatDate(orderMaster.getOpenTime(), "dd.MM.yyyy");
		String time = createTime !=null? DateUtils.formatDate(createTime, "HH:mm"): DateUtils.formatDate(orderMaster.getOpenTime(), "HH:mm");
		orderInfo.setDate(date);
		orderInfo.setTime(time);
		orderInfo.setTableNum(orderMaster.getTableNum());
		String pinterType = orderPrinter.getPinterType();
		orderInfo.setPrintType(pinterType);
		if("3".equals(pinterType)) { //服务打印
			orderInfo.setRemark(ResourceUtils.getValueByLanguage("need-service", setting.getLanguage()));
		} else if("4".equals(pinterType)) {//结账打印
			orderInfo.setRemark(ResourceUtils.getValueByLanguage("pay-bill", setting.getLanguage()));
		}
		return orderInfo;
	}
	private PrinterObj  getPrinterList(List<OrderDetail> orderDetails,OrderPrinterLog orderPrinter){
		PrinterObj printerObj = new PrinterObj();
		List<Integer> detailIds = new ArrayList<Integer>();
		for (OrderDetail orderDetail : orderDetails) {
			detailIds.add(orderDetail.getDetailId());
		}
		List<OrderDetail> details =   orderDetailMapper.queryOrderDetailByGroupCid(detailIds);
		OrderDetail queryParam = new OrderDetail();
		Map<String, List<OrderDetail>>  printerMap = new HashMap<String, List<OrderDetail>>();
		for (OrderDetail orderDetail : details) {
			Category category = categoryMapper.queryPrinterByCategoryId(orderDetail.getCategoryId());
			if(category == null) {
				logger.error("查询分类信息为空,参数="+JSON.toJSONString(orderDetail));
				orderPrinter.setStatus("2");
				orderPrinter.setMsg("查询分类信息为空");
				printerObj.setFlag(false);
				break;
			}
			
			Printer printer = category.getPrinter();
			if(printer ==null) {//子类未配置打印，查父类
				Category categoryDB = categoryMapper.getById(category.getId());
				Category categoryP = categoryMapper.getById(categoryDB.getParentId());
				if(categoryP == null) {
					logger.error("查父类信息为空,参数="+JSON.toJSONString(category));
					//更新打印日志信息
					orderPrinter.setStatus("2");
					orderPrinter.setMsg("查父类信息为空");
					printerObj.setFlag(false);
					break;
				}
				if(categoryP.getPrinter() == null) {
					logger.error("分类未配置打印机信息,参数="+JSON.toJSONString(category));
					//更新打印日志信息
					orderPrinter.setStatus("2");
					orderPrinter.setMsg("分类未配置打印机信息");
					printerObj.setFlag(false);
					break;
				}
				printer = categoryP.getPrinter();
			}
			String printIp = printer.getIp();
			queryParam.setDetailIds(detailIds);
			queryParam.setCategoryId(orderDetail.getCategoryId());
			List<OrderDetail> printerDetails = orderDetailMapper.queryOrderDetail(queryParam);
			if(!CollectionUtils.isEmpty(printerDetails)) {
				if(printerMap.containsKey(printIp)) {
					List<OrderDetail> list = printerMap.get(printIp);
					list.addAll(printerDetails);
					printerMap.put(printIp, list);
				}else {
					printerMap.put(printIp, printerDetails);
				}
			}
		}
		printerObj.setPrinterMap(printerMap);
		return printerObj;
	}
}
