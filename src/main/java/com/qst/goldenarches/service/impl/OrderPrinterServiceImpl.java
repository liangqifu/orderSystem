package com.qst.goldenarches.service.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.service.OrderPrinterService;
@Service
public class OrderPrinterServiceImpl implements OrderPrinterService {
	private static Logger logger = LogManager.getLogger(OrderPrinterServiceImpl.class);
	@Override
	public void handelOrderPrinter(OrderPrinterLog orderPrinter) {
		try {
			logger.info(JSON.toJSONString(orderPrinter));
		} catch (Exception e) {
			logger.error("handelOrderPrinter error",e);
		}
	}

}
