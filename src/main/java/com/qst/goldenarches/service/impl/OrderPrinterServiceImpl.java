package com.qst.goldenarches.service.impl;

import java.util.ArrayList;
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
import com.qst.goldenarches.dao.OrderPrinterLogMapper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.pojo.Printer;
import com.qst.goldenarches.pojo.PrinterObj;
import com.qst.goldenarches.service.OrderPrinterService;
@Service
public class OrderPrinterServiceImpl implements OrderPrinterService {
	private static Logger logger = LogManager.getLogger(OrderPrinterServiceImpl.class);
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	@Autowired
	private OrderPrinterLogMapper orderPrinterLogMapper;
	@SuppressWarnings("unchecked")
	@Override
	public void handelOrderPrinter(OrderPrinterLog orderPrinter) throws Exception{
		try {
			logger.info(JSON.toJSONString(orderPrinter));
			
			List<Orders> goods=new ArrayList<Orders>();
	        goods.add(new Orders("寄件人姓名","寄件人电话","寄件人地址","收件人姓名",
	        		"收件人电话","收件人地址","商品类型",22D));
	        SalesTicket stk=new SalesTicket(goods,"源辰信息","2222","3","38400","38400","0");
	        MyPrinter p=new MyPrinter(stk);
	        p.printer();
	
			/*PrinterJob job  = PrinterJob.getPrinterJob();
			PrintService[] s = job.lookupPrintServices();
			for (int i = 0; i < s.length; i++) {
				s[i].
			}*/
			//1菜品打印 2酒水打印 3服务打印 4通知付款打印
			if("1".equals(orderPrinter.getPinterType())) {//
				OrderRound orderRound =JSON.parseObject(orderPrinter.getContent(), OrderRound.class);
				if(!CollectionUtils.isEmpty(orderRound.getOrderDetails())) {
					PrinterObj printerObj = getPrinterList(orderRound.getOrderDetails(), orderPrinter);
					List<Map<String, Object>> printerList = printerObj.getPrinterList();
					if(printerObj.isFlag()) {
						if(!CollectionUtils.isEmpty(printerList)) {
							//调打印机开始打印
							for (Map<String, Object> map : printerList) {
								Printer printer = (Printer)map.get("printer");
								List<OrderDetail> printDetail = (List<OrderDetail>)map.get("printDetail");
							    
							}
							//更新打印日志信息
							orderPrinter.setStatus("1");
							orderPrinter.setMsg("打印成功");
							orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
						}
					}else {
						orderPrinterLogMapper.updateByPrimaryKeySelective(orderPrinter);
					}
					
				}
				
				
			}else if("2".equals(orderPrinter.getPinterType())) {//2酒水打印
				List<OrderDetail> orderDetails =JSON.parseArray(orderPrinter.getContent(), OrderDetail.class);
				if(!CollectionUtils.isEmpty(orderDetails)) {
					PrinterObj printerObj = getPrinterList(orderDetails, orderPrinter);
					
				}
				
			}else if("3".equals(orderPrinter.getPinterType())) {//3服务打印 
				
			}else if("4".equals(orderPrinter.getPinterType())) {//4通知付款打印
				
			}
			
		} catch (Exception e) {
			logger.error("handelOrderPrinter error",e);
		}
		
		
		
	}
	
	private PrinterObj  getPrinterList(List<OrderDetail> orderDetails,OrderPrinterLog orderPrinter){
		PrinterObj printerObj = new PrinterObj();
		List<Map<String, Object>> printerList = new ArrayList<Map<String, Object>>();
		List<Integer> detailIds = new ArrayList<Integer>();
		for (OrderDetail orderDetail : orderDetails) {
			detailIds.add(orderDetail.getDetailId());
		}
		List<OrderDetail> details =   orderDetailMapper.queryOrderDetailByGroupCid(detailIds);
		OrderDetail queryParam = new OrderDetail();
		Map<String, Object> printerMap = null;
		for (OrderDetail orderDetail : details) {
			Category category = categoryMapper.queryPrinterByCategoryId(orderDetail.getCategoryId());
			if(category == null) {
				logger.error("查询分类信息为空,参数="+JSON.toJSONString(orderDetail));
				orderPrinter.setStatus("2");
				orderPrinter.setMsg("查询分类信息为空");
				printerObj.setFlag(false);
				break;
			}
			printerMap = new HashMap<String, Object>();
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
			queryParam.setDetailIds(detailIds);
			queryParam.setCategoryId(orderDetail.getCategoryId());
			List<OrderDetail> printerDetails = orderDetailMapper.queryOrderDetail(queryParam);
			if(!CollectionUtils.isEmpty(printerDetails)) {
				printerMap.put("printer", printer);
				printerMap.put("printDetail", printerDetails);
				printerList.add(printerMap);
			}
			
		}
		return printerObj;
	}
}
