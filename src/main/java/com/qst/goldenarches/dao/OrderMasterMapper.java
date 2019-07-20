package com.qst.goldenarches.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.OrderMaster;

public interface OrderMasterMapper {
    int deleteByPrimaryKey(Integer orderId);

    int insert(OrderMaster record);

    int insertSelective(OrderMaster record);

    OrderMaster selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(OrderMaster record);

    int updateByPrimaryKey(OrderMaster record);

	List<OrderMaster> queryOrderList(OrderMaster queryParam);

	int delete(Integer orderId);

	String queryMaxOrderNo(@Param("dateStr")String dateStr);

	int checkTableNum(@Param("tableNum") String tableNum);

	
}