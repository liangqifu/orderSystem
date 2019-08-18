package com.qst.goldenarches.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.OrderPrinterLog;

public interface OrderPrinterLogMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderPrinterLog record);

    int insertSelective(OrderPrinterLog record);

    OrderPrinterLog selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderPrinterLog record);

    int updateByPrimaryKey(OrderPrinterLog record);

	List<OrderPrinterLog> queryPrintInfo(@Param("orderId")Integer orderId);

	List<OrderPrinterLog> query(OrderPrinterLog printerLog);
}