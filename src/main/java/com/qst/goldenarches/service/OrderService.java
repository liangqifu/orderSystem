/**
 * FileName: OrderService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:22
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.exception.BusException;
import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Order;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.vo.OrderNeedServiceVo;

import java.util.List;
import java.util.Map;

public interface OrderService {
    List<Order> getAll(Map<String, String> map);

    /**
     * 插入一行订单数据
     * @param map
     * @param phone
     * @return  返回订单的id
     */
    public int insOrder(Map<String,Integer> map,String phone);

    /**
     * 插入一行订单详细表数据
     * @param map
     * @param phone
     * @param lastInsId  对应订单表的id
     * @return 这次插入的每个订单详细表的集合
     */
    public List<Detail> insDetail(Map<String,Integer> map, String phone, int lastInsId);

    /**
     * 判断库存是否充足
     * @param map
     * @param phone
     * @return  充足返回nomal，不充足则返回商品名
     */
    public String judgeInventory(Map<String,Integer> map,String phone);

    /**
     * 判断余额是否充足
     * @param map
     * @param phone
     * @return  充足返回true，不充足返回false
     */
    public boolean judgeBalance(Map<String,Integer> map,String phone);

    /**
     * 判断是否是vip
     * @param phone
     * @return  是返回true，不是返回false
     */
    public boolean judgeVip(String phone);

    /**
     * 获取商品总价格
     * @param map
     * @return  返回总价
     */
    public double getAmount(Map<String,Integer> map);

    /**
     * 修改vip的余额
     * @param map
     * @param phone
     * @return 返回修改的行数
     */
    public int updVIP(Map<String,Integer> map,String phone);

    OrderMaster createOrderMaster(OrderMaster order) throws BusException;;

	void createOrderDrinks(List<OrderDetail> orderDetails) throws BusException;

	void createOrderRound(OrderRound orderRound) throws BusException;

	void needService(OrderNeedServiceVo needServiceVo) throws BusException;

	OrderMaster getOrderInfoByOrderId(Integer orderId) throws BusException;

	List<OrderDetail> queryOrderDetail(OrderDetail param);

	void updateOrderMaster(OrderMaster order) throws BusException;

	/**
	 * 更新订单总额
	 * @param order
	 */
	void updateTotalAmount(OrderMaster order);

	List<OrderMaster> queryOrderList(OrderMaster queryParam);

	void orderSettlement(Integer orderId) throws BusException;

	void delOrder(Map<String, Object> param) throws BusException;

	void notifyPay(Integer orderId)throws BusException;

	void orderCancel(Integer orderId)throws BusException;

	OrderMaster getPrintInfoByOrderId(Integer orderId) throws BusException;

	void doPrint(OrderPrinterLog printerLog) throws BusException;

	List<OrderPrinterLog> queryOrderPrintInfoDetail(OrderPrinterLog printerLog) throws Exception;
}
