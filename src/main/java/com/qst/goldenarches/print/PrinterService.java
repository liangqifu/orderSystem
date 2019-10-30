package com.qst.goldenarches.print;

import java.awt.print.Book;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.PrinterJob;
import java.util.List;

import javax.print.PrintService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.utils.DigitalUtil;

@Service
public class PrinterService {
	private static Logger logger = LogManager.getLogger(PrinterService.class);
	
	public void printer(List<Ticket> tickets) {  
    	for (Ticket ticket : tickets) {
    		try {
				//Book 类提供文档的表示形式，该文档的页面可以使用不同的页面格式和页面 painter
				Book book = new Book(); //要打印的文档
				//PageFormat类描述要打印的页面大小和方向  
				PageFormat pf = new PageFormat();  //初始化一个页面打印对象
				pf.setOrientation(PageFormat.PORTRAIT); //设置页面打印方向，从上往下，从左往右
       
				//设置打印纸页面信息。通过Paper设置页面的空白边距和可打印区域。必须与实际打印纸张大小相符。  
				Paper paper = new Paper(); 
				paper.setSize(158,30000);// 纸张大小
				paper.setImageableArea(0,0,158,30000);// A4(595 X 842)设置打印区域，其实0，0应该是72，72，因为A4纸的默认X,Y边距是72  
				pf.setPaper(paper);  
 
				book.append(ticket,pf); 
				PrinterJob job = PrinterJob.getPrinterJob();   //获取打印服务对象  
				job.setPageable(book);  //设置打印类  
				
				PrintService[] printServices =  PrinterJob.lookupPrintServices();
				if(printServices.length == 0) {
					logger.warn("没有配置打印机");
					return ;
				}
				for (int i = 0; i < printServices.length; i++) {
					PrintService printService = printServices[i];
					String name = printService.getName();
					if(ticket.getPrinterIp().equals(name)) {
						boolean flag = DigitalUtil.isHostReachable(name, 100);
						if(flag) {
							logger.info("打印机名称：{}",name);
							job.setPrintService(printService);
							job.print(); //开始打印 
						}else {
							logger.info("打印机名称：{},不在线",name);
						}
						break;
					}
				}
				
			} catch (Exception e) {
				logger.error("打印异常，参数={"+ticket+"}",e);
			}
		}
    } 
	
	public void printerPC(List<TicketPC> tickets) {  
    	for (TicketPC ticket : tickets) {
    		try {
				//Book 类提供文档的表示形式，该文档的页面可以使用不同的页面格式和页面 painter
				Book book = new Book(); //要打印的文档
				//PageFormat类描述要打印的页面大小和方向  
				PageFormat pf = new PageFormat();  //初始化一个页面打印对象
				pf.setOrientation(PageFormat.PORTRAIT); //设置页面打印方向，从上往下，从左往右
       
				//设置打印纸页面信息。通过Paper设置页面的空白边距和可打印区域。必须与实际打印纸张大小相符。  
				Paper paper = new Paper(); 
				paper.setSize(158,30000);// 纸张大小
				paper.setImageableArea(0,0,158,30000);// A4(595 X 842)设置打印区域，其实0，0应该是72，72，因为A4纸的默认X,Y边距是72  
				pf.setPaper(paper);  
 
				book.append(ticket,pf); 
				PrinterJob job = PrinterJob.getPrinterJob();   //获取打印服务对象  
				job.setPageable(book);  //设置打印类  
				
				PrintService[] printServices =  PrinterJob.lookupPrintServices();
				if(printServices.length == 0) {
					logger.warn("没有配置打印机");
					return ;
				}
				for (int i = 0; i < printServices.length; i++) {
					PrintService printService = printServices[i];
					String name = printService.getName();
					if(ticket.getPrinterIp().equals(name)) {
						boolean flag = DigitalUtil.isHostReachable(name, 100);
						if(flag) {
							logger.info("打印机名称：{}",name);
							job.setPrintService(printService);
							job.print(); //开始打印 
						}else {
							logger.info("打印机名称：{},不在线",name);
						}
						break;
					}
				}
				
			} catch (Exception e) {
				logger.error("打印异常，参数={"+ticket+"}",e);
			}
		}
    } 
	
	
}
