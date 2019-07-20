/**
 * FileName: OrderServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:22
 * Description:
 */
package com.qst.goldenarches.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.qst.goldenarches.dao.OrderDetailMapper;
import com.qst.goldenarches.dao.OrderMapper;
import com.qst.goldenarches.dao.OrderMasterMapper;
import com.qst.goldenarches.dao.OrderPrinterLogMapper;
import com.qst.goldenarches.dao.OrderRoundMapper;
import com.qst.goldenarches.dao.SettingMapper;
import com.qst.goldenarches.exception.BusException;
import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Order;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.pojo.VIP;
import com.qst.goldenarches.service.OrderService;
import com.qst.goldenarches.thread.EventStorage;
import com.qst.goldenarches.utils.DigitalUtil;
import com.qst.goldenarches.utils.OrderNoUtil;
import com.qst.goldenarches.vo.OrderNeedServiceVo;

@Service
public class OrderServiceImpl implements OrderService {
	private static Logger logger = LogManager.getLogger(OrderServiceImpl.class);
	private static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderMasterMapper orderMasterMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private OrderRoundMapper orderRoundMapper;
    @Autowired
    private OrderPrinterLogMapper orderPrinterLogMapper;
    
    @Autowired
	private SettingMapper settingMapper;
    
    

    public List<Order> getAll(Map<String, String> map) {
        return orderMapper.selectAll(map);
    }


    public int insOrder(Map<String, Integer> map,String phone) {
        Order order = new Order();
        int vipId ;
        double amount = getAmount(map);//原价

        if(phone==null||"".equals(phone)){
            vipId=-1;
        }else{
            vipId = orderMapper.selAllByPhone(phone).getId();//根据电话号查找ID
            amount = amount * 0.8;//会员八折优惠
        }

//        if(orderMapper.selAllByPhone(phone) == null){
//            //当买家不是会员，用手机尾号后4位做ID，若不足4位，用所有手机号做ID
//            if(phone.length() >= 4){
//                vipId = Integer.parseInt(phone.substring(phone.length() - 4,phone.length()));
//            }else{
//                vipId = Integer.parseInt(phone);
//            }
//        } else{
//            vipId = orderMapper.selAllByPhone(phone).getId();//根据电话号查找ID
//            amount = amount * 0.8;//会员八折优惠
//        }
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime =sdf.format(new Date());//获取当前时间并转换格式

        order.setCreateTime(createTime);
        order.setBid(vipId);
        order.setAmount(amount);//存的是优惠后的价格
        orderMapper.insOrder(order);//新增订单表

        int lastInsId = orderMapper.selLastInsId();//查询最后一次插入操作插入的ID
        return lastInsId;//返回最后一次插入操作的id，不返回插入订单的行数
    }


    public List<Detail> insDetail(Map<String, Integer> map, String phone, int lastInsId) {
        List<Detail> list = new ArrayList<Detail>();//用于接收本次订单所有的订单详细对象
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            Detail detail = new Detail();
            detail.setOid(lastInsId);
            detail.setPid(pid);
            detail.setNumber(number);
            detail.setPname(orderMapper.selAllByPid(pid).getName());
            if(orderMapper.selAllByPhone(phone) == null){//判断买家是否是会员
                detail.setPrice(orderMapper.selAllByPid(pid).getPrice());
            } else{
                detail.setPrice(orderMapper.selAllByPid(pid).getPrice()*0.8);
            }
            //detail.setPrice(orderMapper.selAllByPid(pid).getPrice());
            orderMapper.insDetail(detail);//订单详细表的新增
            orderMapper.updProduct(detail);//商品库存的减少
            if(number != 0)//必须把数量为0的去掉
                list.add(detail);//再把单个订单详细对象添加进集合
        }
        return list;//返回整个集合
    }


    public String judgeInventory(Map<String, Integer> map, String phone) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            /**
             * 如果商品库存不足，则返回库存不足的name
             */
            if(orderMapper.selAllByPid(pid).getInventory() < number){
                return orderMapper.selAllByPid(pid).getName();
            }
        }
        return "nomal";
    }


    public boolean judgeBalance(Map<String, Integer> map, String phone) {
        double amount = getAmount(map);//本次订单商品总价
        /**
         * 如果商品总价大于会员卡余额，则返回false
         */
        if(amount > orderMapper.selAllByPhone(phone).getBalance()){
            return false;
        }
        return true;
    }


    public boolean judgeVip(String phone) {
        if(orderMapper.selAllByPhone(phone) == null)
            return false;
        else
            return true;
    }


    public double getAmount(Map<String, Integer> map) {
        double amount = 0;//本次订单商品总价
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            double price = orderMapper.selAllByPid(pid).getPrice();//商品单价
            amount= amount + price * number;//加上单件商品总价
        }
        return amount;
    }


    public int updVIP(Map<String, Integer> map, String phone) {
        double amount = getAmount(map);
        double newAmount = amount * 0.8;//会员八折优惠
        //先把最终会员卡的余额算出来然后直接存进去
        double newBalance = orderMapper.selAllByPhone(phone).getBalance() - newAmount;
        VIP vip = new VIP();
        vip.setBalance(newBalance);
        vip.setPhone(phone);
        int index = orderMapper.updVIP(vip);
        return index;
    }


	@Override
	public OrderMaster createOrderMaster(OrderMaster order) throws BusException{
		
		int count = orderMasterMapper.checkTableNum(order.getTableNum());
		if(count > 0) {
			throw new  BusException(101, "台号已被占用，请重新输入台号");
		}
		order.setOrderNo(this.getOrderNo());
		Setting setting = settingMapper.getSettingInfo();
		if(setting != null) {
			double adultTotalAmount = 0l;
			double childTotalAmount = 0l;
			Integer adult = order.getAdult();
			Integer child = order.getChild();
			String orderType = order.getOrderType();
			if("1".equals(orderType)) {//午餐
				if(adult != null) {
					adultTotalAmount =  DigitalUtil.mul(setting.getAdultLunchPrice(), adult);
				}
				if(child != null) {
					childTotalAmount =  DigitalUtil.mul(setting.getChildLunchPrice(), child);
				}
			}else {//晚餐
				if(adult != null) {
					adultTotalAmount =  DigitalUtil.mul(setting.getAdultDinnerPrice(), adult);
				}
				if(child != null) {
					childTotalAmount =  DigitalUtil.mul(setting.getChildDinnerPrice(), child);
				}
			}
			double totalAmount = DigitalUtil.add(adultTotalAmount, childTotalAmount);
			BigDecimal b = new BigDecimal(totalAmount);
			totalAmount = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			order.setTotalAmount(totalAmount);
		}
		orderMasterMapper.insertSelective(order);
		return order;
	}
	
	private String getOrderNo() {
		String result = "";
		String dateStr = simpleDateFormat.format(new Date());
		String maxOrderNo = orderMasterMapper.queryMaxOrderNo(dateStr);
		if(StringUtils.isEmpty(maxOrderNo)) {
			result = "0001";
		}else {
			Integer code = Integer.valueOf(maxOrderNo)+1;
			if(code<10) {
				result = "000"+String.valueOf(code);
			} else if (code>=10 && code<100) {
				result = "00"+String.valueOf(code);
			}else if (code>=100) {
				result = "0"+String.valueOf(code);
			}else {
				result =String.valueOf(code);
			}
		}
		return dateStr+result;
	}


	@Override
	@Transactional(rollbackFor = {BusException.class,Exception.class})
	public void createOrderDrinks(List<OrderDetail> orderDetails) throws BusException {
		if(CollectionUtils.isEmpty(orderDetails)) {
			throw new BusException("参数为空");
		}
		Set<Integer> orderIds = new HashSet<Integer>();
		for (OrderDetail orderDetail : orderDetails) {
			orderDetail.setDetailType("1");
			if(orderDetail.getOrderId() == null || orderDetail.getOrderId().intValue() == 0) {
				throw new BusException("订单OrderId参数不正确");
			}
			orderIds.add(orderDetail.getOrderId());
		}
		if(orderIds.size() >1 || orderIds.size() ==0) {
			throw new BusException("订单OrderId参数不正确");
		}
		Integer orderId = orderIds.iterator().next();
		OrderMaster orderMsater = orderMasterMapper.selectByPrimaryKey(orderId);
		if(orderMsater == null) {
			throw new BusException("订单主表数据不存在");
		}
		int ret = orderDetailMapper.insertBatch(orderDetails);
		
		this.updateTotalAmount(orderMsater);
		OrderPrinterLog printerLog = new OrderPrinterLog();
		printerLog.setOrderId(orderMsater.getOrderId());
		printerLog.setContent(JSON.toJSONString(orderDetails));
		printerLog.setPinterType("2");
		printerLog.setStatus("0");
		ret = orderPrinterLogMapper.insert(printerLog);
		if(ret > 0) {
			try {
				EventStorage.getInstance().putEvent(printerLog);
			} catch (InterruptedException e) {
				logger.error("createOrderDrinks存放异常",e);
			}
		}
	}


	@Override
	@Transactional(rollbackFor = {BusException.class,Exception.class})
	public void createOrderRound(OrderRound orderRound) throws BusException {
		if(CollectionUtils.isEmpty(orderRound.getOrderDetails())) {
			throw new BusException("参数orderDetails为空");
		}
		OrderMaster orderMsater = orderMasterMapper.selectByPrimaryKey(orderRound.getOrderId());
		if(orderMsater == null) {
			throw new BusException("订单主表数据不存在");
		}
		Integer maxNum = orderRoundMapper.getMaxNumByOrderId(orderRound.getOrderId());
		orderRound.setNum(maxNum +1);
		
		int ret =  orderRoundMapper.insert(orderRound);
		if(ret == 0) {
			throw new BusException("保存数据失败");
		}
		for (OrderDetail orderDetail : orderRound.getOrderDetails()) {
			orderDetail.setDetailType("2");
			orderDetail.setOrderId(orderMsater.getOrderId());
			orderDetail.setRoundId(orderRound.getId());
		}
		ret = orderDetailMapper.insertBatch(orderRound.getOrderDetails());
		if(ret == 0) {
			throw new BusException("保存数据失败");
		}
		OrderPrinterLog printerLog = new OrderPrinterLog();
		printerLog.setOrderId(orderMsater.getOrderId());
		printerLog.setContent(JSON.toJSONString(orderRound));
		printerLog.setPinterType("1");
		printerLog.setStatus("0");
		ret = orderPrinterLogMapper.insert(printerLog);
		if(ret > 0) {
			try {
				EventStorage.getInstance().putEvent(printerLog);
			} catch (InterruptedException e) {
				logger.error("createOrderRound存放异常",e);
			}
		}
	}


	@Override
	@Transactional(rollbackFor = {BusException.class,Exception.class})
	public void needService(OrderNeedServiceVo needServiceVo) throws BusException {
		
		if(CollectionUtils.isEmpty(needServiceVo.getNeedServiceDetails())) {
			throw new BusException("needServiceDetails 参数为空");
		}
		
		for (OrderDetail orderDetail : needServiceVo.getNeedServiceDetails()) {
			orderDetail.setDetailType("3");
			orderDetail.setOrderId(needServiceVo.getOrderId());
		}
		
		int ret = orderDetailMapper.insertBatch(needServiceVo.getNeedServiceDetails());
		if(ret == 0) {
			throw new BusException("保存数据失败");
		}
		OrderPrinterLog printerLog = new OrderPrinterLog();
		printerLog.setOrderId(needServiceVo.getOrderId());
		printerLog.setContent(JSON.toJSONString(needServiceVo));
		printerLog.setPinterType("3");
		printerLog.setStatus("0");
		ret = orderPrinterLogMapper.insert(printerLog);
		if(ret > 0) {
			try {
				EventStorage.getInstance().putEvent(printerLog);
			} catch (InterruptedException e) {
				logger.error("needService存放异常",e);
			}
		}
		
	}


	@Override
	public OrderMaster getOrderInfoByOrderId(Integer orderId) throws BusException {
		OrderMaster orderMaster = orderMasterMapper.selectByPrimaryKey(orderId);
		if(orderMaster == null) {
			throw new BusException("订单数据不存在");
		}
		OrderRound param = new OrderRound();
		param.setState("0");
		param.setOrderId(orderId);
		List<OrderRound> orderRounds = orderRoundMapper.query(param);
		orderMaster.setOrderRounds(orderRounds);
		return orderMaster;
	}

	@Override
	public List<OrderDetail> queryOrderDetail(OrderDetail param) {
		return orderDetailMapper.queryOrderDetail(param);
	}


	@Override
	@Transactional(rollbackFor = {BusException.class, Exception.class})
	public void updateOrderMaster(OrderMaster order) throws BusException {
		if(!StringUtils.isEmpty(order.getTableNum())) {
			int count = orderMasterMapper.checkTableNum(order.getTableNum());
			if(count > 0) {
				throw new  BusException(101, "台号已被占用，请重新输入台号");
			}
		}
		orderMasterMapper.updateByPrimaryKeySelective(order);
		//更新订单总额
		this.updateTotalAmount(order);
	}


	@Override
	public void updateTotalAmount(OrderMaster order) {
		OrderMaster orderMaster =orderMasterMapper.selectByPrimaryKey(order.getOrderId());
		if(orderMaster != null) {
			Setting setting = settingMapper.getSettingInfo();
			if(setting != null) {
				double adultTotalAmount = 0l;
				double childTotalAmount = 0l;
				Integer adult = orderMaster.getAdult();
				Integer child = orderMaster.getChild();
				String orderType = orderMaster.getOrderType();
				if("1".equals(orderType)) {//午餐
					if(adult != null) {
						adultTotalAmount =  DigitalUtil.mul(setting.getAdultLunchPrice(), adult);
					}
					if(child != null) {
						childTotalAmount =  DigitalUtil.mul(setting.getChildLunchPrice(), child);
					}
				}else {//晚餐
					if(adult != null) {
						adultTotalAmount =  DigitalUtil.mul(setting.getAdultDinnerPrice(), adult);
					}
					if(child != null) {
						childTotalAmount =  DigitalUtil.mul(setting.getChildDinnerPrice(), child);
					}
				}
				double totalAmount = DigitalUtil.add(adultTotalAmount, childTotalAmount);
				if(totalAmount == 0) {
					totalAmount = orderMaster.getTotalAmount()==null?0l:orderMaster.getTotalAmount();
				}
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("orderId", order.getOrderId());
				Double orderDetailTotalAmount = orderDetailMapper.getTotalAmountByOrderId(param);
				OrderMaster record = new OrderMaster();
				if(orderDetailTotalAmount != null) {
					record.setDrinksTotalAmount(orderDetailTotalAmount);
					totalAmount = DigitalUtil.add(totalAmount, orderDetailTotalAmount);
				}
				BigDecimal b = new BigDecimal(totalAmount);
				totalAmount = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				record.setOrderId(orderMaster.getOrderId());
				record.setTotalAmount(totalAmount);
				orderMasterMapper.updateByPrimaryKeySelective(record);
			}
			
		}
		
	}

	@Override
	public List<OrderMaster> queryOrderList(OrderMaster queryParam) {
		return orderMasterMapper.queryOrderList(queryParam);
	}

	@Override
	public void orderSettlement(Integer orderId) throws BusException{
		
		OrderMaster orderMaster = new OrderMaster();
		orderMaster.setOrderId(orderId);
		orderMaster.setStatus("2");
		int ret = orderMasterMapper.updateByPrimaryKeySelective(orderMaster);
		if(ret == 0) {
			throw new BusException("订单结账失败，更新数据不存在");
		}
		
	}


	@Override
	@Transactional(rollbackFor = {BusException.class,Exception.class} )
	public void delOrder(Map<String, Object> param) throws BusException {
		if(StringUtils.isEmpty(param.get("orderId"))) {
			throw new BusException("orderId 参数为空");
		}
		Integer orderId = (Integer)param.get("orderId");
		try {
			orderMasterMapper.delete(orderId);
			orderRoundMapper.deleteByOrderId(orderId);
			orderDetailMapper.deleteByOrderId(orderId);
		} catch (Exception e) {
			throw new BusException(e);
		}
	}


	@Override
	@Transactional(rollbackFor = {BusException.class,Exception.class} )
	public void notifyPay(Integer orderId) throws BusException {
		OrderMaster orderMaster = orderMasterMapper.selectByPrimaryKey(orderId);
		if(orderMaster == null) {
			throw new BusException("订单数据不存在");
		}
		
		OrderMaster param = new OrderMaster();
		param.setOrderId(orderId);
		param.setStatus("1");
		orderMasterMapper.updateByPrimaryKeySelective(param);
		
		OrderPrinterLog printerLog = new OrderPrinterLog();
		printerLog.setOrderId(orderMaster.getOrderId());
		printerLog.setContent(JSON.toJSONString(orderMaster));
		printerLog.setPinterType("4");
		printerLog.setStatus("0");
		int ret = orderPrinterLogMapper.insert(printerLog);
		if(ret > 0) {
			try {
				EventStorage.getInstance().putEvent(printerLog);
			} catch (InterruptedException e) {
				logger.error("notifyPay存放异常",e);
			}
		}
		
	}


	@Override
	public void orderCancel(Integer orderId) throws BusException {
		OrderMaster orderMaster = orderMasterMapper.selectByPrimaryKey(orderId);
		if(orderMaster == null) {
			throw new BusException("订单数据不存在");
		}
		OrderMaster param = new OrderMaster();
		param.setOrderId(orderId);
		param.setStatus("3");
		orderMasterMapper.updateByPrimaryKeySelective(param);
	}
}
