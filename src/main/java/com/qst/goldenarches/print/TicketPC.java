package com.qst.goldenarches.print;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.util.List;

import org.springframework.util.CollectionUtils;

import com.alibaba.fastjson.JSON;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.utils.ResourceUtils;

public class TicketPC implements Printable{
	
	private OrderInfo orderInfo;
	/**
	 * 打印机IP地址
	 */
	private String printerIp;
	
    private Setting setting;
	
	
	
	public TicketPC(OrderInfo orderInfo, String printerIp,Setting setting) {
		this.orderInfo = orderInfo;
		this.printerIp = printerIp;
		this.setting = setting;
	}
	public OrderInfo getOrderInfo() {
		return orderInfo;
	}
	public void setOrderInfo(OrderInfo orderInfo) {
		this.orderInfo = orderInfo;
	}
	public String getPrinterIp() {
		return printerIp;
	}
	public void setPrinterIp(String printerIp) {
		this.printerIp = printerIp;
	}
	
	public Setting getSetting() {
		return setting;
	}
	public void setSetting(Setting setting) {
		this.setting = setting;
	}
	/**
	 * 打印方法
	 * graphics - 用来绘制页面的上下文，即打印的图形
	 * pageFormat - 将绘制页面的大小和方向，即设置打印格式，如页面大小一点为计量单位（以1/72 英寸为单位，1英寸为25.4毫米。A4纸大致为595 × 842点）
	 * 				小票纸宽度一般为58mm，大概为165点
	 * pageIndex - 要绘制的页面从 0 开始的索引 ，即页号
	 */
	@Override
	public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
		//此 Graphics2D 类扩展 Graphics 类，以提供对几何形状、坐标转换、颜色管理和文本布局更为复杂的控制。
		//它是用于在 Java(tm) 平台上呈现二维形状、文本和图像的基础类。 
		Graphics2D g2 = (Graphics2D) graphics;  
 
		g2.setColor(Color.black);//设置打印颜色为黑色  
 
		//打印起点坐标  
		double x= pageFormat.getImageableX();  //返回与此 PageFormat相关的 Paper对象的可成像区域左上方点的 x坐标。  
		double y= pageFormat.getImageableY();  //返回与此 PageFormat相关的 Paper对象的可成像区域左上方点的 y坐标。
		//Font.PLAIN： 普通样式常量  	Font.ITALIC 斜体样式常量	Font.BOLD 粗体样式常量。
		Font font = null;
		int fontSize = 22;
		font = new Font("SimSun",Font.BOLD,fontSize); //根据指定名称、样式和磅值大小，创建一个新 Font。
		g2.setFont(font);//设置标题打印字体   
		
		float heigth = font.getSize2D();//获取字体的高度  
		//台号 
		
		g2.drawString(ResourceUtils.getValueByLanguage("table-num", setting.getLanguage())+" "+orderInfo.getTableNum(),(float)x+15,(float)y+heigth); 
		
		float line = 2*heigth; //下一行开始打印的高度
		
		int fontSize1 = 12;
		g2.setFont(new Font("SimSun", Font.PLAIN,fontSize1));//设置正文字体  
		
		heigth = font.getSize2D();// 字体高度  
		
		line+=2;
		//日期 时间 餐区 
		g2.drawString(orderInfo.getDate()+" "+orderInfo.getTime()+" "+orderInfo.getArea(),(float)x+15,(float)y+line); 
		line+=heigth-3;
		
		//虚线设置
		g2.setStroke(new BasicStroke(1f,BasicStroke.CAP_BUTT,BasicStroke.JOIN_MITER,4.0f,new float[]{4.0f},0.0f));  
		//在此图形上下文的坐标系中使用当前颜色在点 (x1, y1) 和 (x2, y2) 之间画一条线。 即绘制虚线
		g2.drawLine((int)x,(int)(y+line),(int)x+158,(int)(y+line));
		line+=2; 
		g2.setStroke(new BasicStroke(1f,BasicStroke.CAP_BUTT,BasicStroke.JOIN_MITER,4.0f,new float[]{4.0f},0.0f));
		//在此图形上下文的坐标系中使用当前颜色在点 (x1, y1) 和 (x2, y2) 之间画一条线。 即绘制虚线
		g2.drawLine((int)x,(int)(y+line),(int)x+158,(int)(y+line));
		line+=heigth+4; 
		
		List<OrderDetailInfo> detailInfos = orderInfo.getDetailInfos();
		if(!CollectionUtils.isEmpty(detailInfos)) {
			for (OrderDetailInfo orderDetailInfo : detailInfos) {
				g2.setFont(new Font("SimSun",Font.BOLD,12));
				heigth = font.getSize2D();// 字体高度
				String a = orderDetailInfo.getNumber()+"*"+orderDetailInfo.getProductName()+"....";
				String b = String.valueOf(orderDetailInfo.getPrice())+ResourceUtils.getValueByLanguage("currency", setting.getLanguage());
				g2.drawString(a+b,(float)x+15,(float)y+line);
				line+=heigth;
			}
		}
		
		line+=6;
		g2.setFont(new Font("SimSun",Font.BOLD,14));
		String totalStr = ResourceUtils.getValueByLanguage("total", setting.getLanguage())+String.valueOf(orderInfo.getTotalAmount())+ResourceUtils.getValueByLanguage("currency", setting.getLanguage());
		g2.drawString(totalStr,(float)x+25,(float)y+line);
		
		line+=20;
		g2.setFont(new Font("SimSun",Font.BOLD,12));
		g2.drawString("inkl 19% Mwst",(float)x+20,(float)y+line);
		
		switch (pageIndex) {  
		case 0:  
			return PAGE_EXISTS;  //0 
		default:  
			return NO_SUCH_PAGE;   //1
		}  
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
	
}
