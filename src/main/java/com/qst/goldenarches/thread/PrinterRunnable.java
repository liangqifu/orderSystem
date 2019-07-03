package com.qst.goldenarches.thread;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.qst.goldenarches.controller.AppController;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.service.OrderPrinterService;

public class PrinterRunnable implements Runnable{
	private static Logger logger = LogManager.getLogger(AppController.class);
	private OrderPrinterService orderPrinterService;
	
	public PrinterRunnable(OrderPrinterService orderPrinterService) {
		this.orderPrinterService = orderPrinterService;
	}

	@Override
	public void run() {
		while (true) {
			try {
				OrderPrinterLog orderPrinter = EventStorage.getInstance().takeEvent();
				orderPrinterService.handelOrderPrinter(orderPrinter);
			} catch (Exception e) {
				logger.error("PrinterRunnable异常", e);
			}
		}
		
	}

}
