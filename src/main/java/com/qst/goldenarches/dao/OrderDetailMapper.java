package com.qst.goldenarches.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.OrderDetail;

public interface OrderDetailMapper {

	int deleteByPrimaryKey(Integer detailId);

    int insert(OrderDetail record);
    int insertBatch(List<OrderDetail> list);

    int insertSelective(OrderDetail record);
    

    OrderDetail selectByPrimaryKey(Integer detailId);

    int updateByPrimaryKeySelective(OrderDetail record);

    int updateByPrimaryKey(OrderDetail record);

	List<OrderDetail> queryOrderDetail(OrderDetail param);
	
	Double getTotalAmountByOrderId(Map<String, Object> param);

	int deleteByOrderId(Integer orderId);
	
	List<OrderDetail> queryOrderDetailByGroupCid(List<Integer> detailIds);

	Map<String, Object> queryDrinksAndServiceCount(@Param("orderId")Integer orderId);

	List<Map<String, Object>> queryEveryProTypeSaleNum(Map<String, Object> params);

	List<Map<String, Object>> queryAmountMoneyOfType(Map<String, Object> params);
	List<Map<String, Object>> queryEveryMonthSaleNum(Map<String, Object> params);
	Map<String, Object> queryEveryMonthMoney(Map<String, Object> params);
}