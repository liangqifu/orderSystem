package com.qst.goldenarches.web;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.qst.goldenarches.service.OrderPrinterService;
import com.qst.goldenarches.thread.PrinterRunnable;

@Component
public class StartupListener implements ApplicationContextAware {
    @Autowired
	private OrderPrinterService orderPrinterService;
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		 new Thread(new PrinterRunnable(orderPrinterService)).start();
	}
}
