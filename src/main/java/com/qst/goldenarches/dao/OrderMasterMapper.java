package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.OrderMaster;

public interface OrderMasterMapper {
    int deleteByPrimaryKey(Integer orderId);

    int insert(OrderMaster record);

    int insertSelective(OrderMaster record);

    OrderMaster selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(OrderMaster record);

    int updateByPrimaryKey(OrderMaster record);

	
}