package com.qst.goldenarches.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.OrderRound;

public interface OrderRoundMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderRound record);

    int insertSelective(OrderRound record);

    OrderRound selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderRound record);

    int updateByPrimaryKey(OrderRound record);

	Integer getMaxNumByOrderId(@Param("orderId") Integer orderId);

	List<OrderRound> query(OrderRound param);

	int deleteByOrderId(Integer orderId);
}