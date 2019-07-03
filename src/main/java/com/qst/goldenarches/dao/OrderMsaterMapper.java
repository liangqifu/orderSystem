package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.OrderMsater;

public interface OrderMsaterMapper {
    int deleteByPrimaryKey(Integer orderId);

    int insert(OrderMsater record);

    int insertSelective(OrderMsater record);

    OrderMsater selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(OrderMsater record);

    int updateByPrimaryKey(OrderMsater record);

	
}