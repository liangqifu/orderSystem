package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.OrderDetail;

public interface OrderDetailMapper {

	int deleteByPrimaryKey(Integer detailId);

    int insert(OrderDetail record);

    int insertSelective(OrderDetail record);

    OrderDetail selectByPrimaryKey(Integer detailId);

    int updateByPrimaryKeySelective(OrderDetail record);

    int updateByPrimaryKey(OrderDetail record);
}