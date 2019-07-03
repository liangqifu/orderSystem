package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.OrderPrinterLog;

public interface OrderPrinterLogMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderPrinterLog record);

    int insertSelective(OrderPrinterLog record);

    OrderPrinterLog selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderPrinterLog record);

    int updateByPrimaryKey(OrderPrinterLog record);
}