package com.qst.goldenarches.utils;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.util.CollectionUtils;

import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.Setting;

public class ExcelUtil {
	private static HSSFWorkbook wb;

	private static CellStyle titleStyle;		// 标题行样式
	private static Font titleFont;				// 标题行字体		
	private static CellStyle headStyle;			// 表头行样式
	private static Font headFont;				// 表头行字体
	private static CellStyle contentStyle ;		// 内容行样式
	private static Font contentFont;			// 内容行字体
	
	/**
	 * @Description: 将Map里的集合对象数据输出Excel数据流
	 */
	public static void exportExcel(ExportOrderInfo setInfo) throws Exception{
		init();
		//每个Sheet表的名称和数据集合的集合
		List<OrderMaster> orderList = setInfo.getOrderList();
		Setting setting = setInfo.getSetting();
		//使用处理好的Sheet表的名称创建出所有的Sheet表
		HSSFSheet sheet = getSheet(ResourceUtils.getValueByLanguage("excel-title", setting.getLanguage()));
		// 标题行
		CellRangeAddress titleRange = new CellRangeAddress(0, 0, 0, 10);
		sheet.addMergedRegion(titleRange);
		HSSFRow titleRow = sheet.createRow(0);
		titleRow.setHeight((short) 800);
		HSSFCell titleCell = titleRow.createCell(0);
		titleCell.setCellStyle(titleStyle);
		titleCell.setCellValue(ResourceUtils.getValueByLanguage("excel-title", setting.getLanguage()));
		// 表头
		HSSFRow headRow = sheet.createRow(1);
		headRow.setHeight((short) 350);
		// 列头名称
		HSSFCell headCell = null;
		headCell = headRow.createCell(0);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-no", setting.getLanguage()));
		headCell = headRow.createCell(1);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-area", setting.getLanguage()));
		headCell = headRow.createCell(2);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-table-num", setting.getLanguage()));
		headCell = headRow.createCell(3);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-adult", setting.getLanguage()));
		headCell = headRow.createCell(4);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-child", setting.getLanguage()));
		headCell = headRow.createCell(5);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-type", setting.getLanguage()));
		headCell = headRow.createCell(6);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-total-amount", setting.getLanguage()));
		headCell = headRow.createCell(7);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-product-name", setting.getLanguage()));
		headCell = headRow.createCell(8);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-product-no", setting.getLanguage()));
		headCell = headRow.createCell(9);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-product-number", setting.getLanguage()));
		headCell = headRow.createCell(10);
		headCell.setCellStyle(headStyle);
		headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-product-price", setting.getLanguage()));
		int rowIndex = 2;
		int index = 0;
		int firstRow =0;
		int lastRow  = 0;
		for (OrderMaster order  : orderList){
			 List<OrderDetail> orderDetails = order.getOrderDetails();
			 if(!CollectionUtils.isEmpty(orderDetails)) {
				int  size = orderDetails.size();
				if(firstRow == 0) {
					firstRow =(size * index)+2;
				}
				for (OrderDetail detail : orderDetails) {
					HSSFRow bobayRow = sheet.createRow(rowIndex);
					headCell = bobayRow.createCell(0);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getOrderNo());
					headCell = bobayRow.createCell(1);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getArea().getName());
					headCell = bobayRow.createCell(2);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getTableNum());
					headCell = bobayRow.createCell(3);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getAdult());
					headCell = bobayRow.createCell(4);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getChild());
					headCell = bobayRow.createCell(5);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(ResourceUtils.getValueByLanguage("excel-order-type-"+order.getOrderType(), setting.getLanguage()));
					headCell = bobayRow.createCell(6);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(order.getTotalAmount());
					headCell = bobayRow.createCell(7);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(detail.getProductName());
					headCell = bobayRow.createCell(8);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(detail.getProduct().getNo());
					headCell = bobayRow.createCell(9);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(detail.getProductNumber());
					headCell = bobayRow.createCell(10);
					headCell.setCellStyle(contentStyle);
					headCell.setCellValue(detail.getProductPrice());
					rowIndex ++;
				}
				index ++;
				lastRow = firstRow + size-1;
				if(firstRow != lastRow) {
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 0, 0));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 1, 1));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 2, 2));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 3, 3));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 4, 4));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 5, 5));
					sheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, 6, 6));
				}
				firstRow = lastRow+1;
			 }
		}
		adjustColumnSize(sheet);
		BufferedOutputStream bufferedOutPut = null;
		try {
			bufferedOutPut = new BufferedOutputStream(setInfo.getOut());
			bufferedOutPut.flush();
			wb.write(bufferedOutPut);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(bufferedOutPut !=null) {
				bufferedOutPut.close();
			}
		}
	}

	/**
	 * @Description: 初始化标题、列名称、表格内容等的字体、样式
	 */
	private static void init(){
		wb = new HSSFWorkbook();
		
		titleFont = wb.createFont();
		titleStyle = wb.createCellStyle();
		headFont = wb.createFont();
		headStyle = wb.createCellStyle();
		contentFont = wb.createFont();
		contentStyle = wb.createCellStyle();
		
		initTitleCellStyle();
		initTitleFont();
		initHeadCellStyle();
		initHeadFont();
		initContentCellStyle();
		initContentFont();
	}

	/**
	 * @Description: 自动调整列宽
	 */
	private static void adjustColumnSize(HSSFSheet sheet) {
		for(int i = 0; i < 11; i++){
			sheet.autoSizeColumn(i, true);
		}
	}





	/**
	 * @Description: 创建所有的Sheet
	 */
	private static HSSFSheet getSheet(String sheetname){
		return wb.createSheet(sheetname);
	}

	

	/**
	 * @Description: 初始化标题行样式
	 */
	private static void initTitleCellStyle(){
		titleStyle.setAlignment(HorizontalAlignment.CENTER_SELECTION);
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		titleStyle.setFont(titleFont);
		titleStyle.setFillBackgroundColor(IndexedColors.BLACK.index);
	}

	

	/**
	 * @Description: 初始化表头行样式
	 */
	private static void initHeadCellStyle(){
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headStyle.setFont(headFont);
		headStyle.setFillBackgroundColor(IndexedColors.YELLOW.index);
		headStyle.setBorderTop(BorderStyle.MEDIUM);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		headStyle.setTopBorderColor(IndexedColors.BLACK.index);
		headStyle.setBottomBorderColor(IndexedColors.BLACK.index);
		headStyle.setLeftBorderColor(IndexedColors.BLACK.index);
		headStyle.setRightBorderColor(IndexedColors.BLACK.index);
	}

	/**
	 * @Description: 初始化内容行样式
	 */
	private static void initContentCellStyle(){
		contentStyle.setAlignment(HorizontalAlignment.CENTER);
		contentStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		contentStyle.setFont(contentFont);
		contentStyle.setBorderTop(BorderStyle.THIN);
		contentStyle.setBorderBottom(BorderStyle.THIN);
		contentStyle.setBorderLeft(BorderStyle.THIN);
		contentStyle.setBorderRight(BorderStyle.THIN);
		contentStyle.setTopBorderColor(IndexedColors.BLACK.index);
		contentStyle.setBottomBorderColor(IndexedColors.BLACK.index);
		contentStyle.setLeftBorderColor(IndexedColors.BLACK.index);
		contentStyle.setRightBorderColor(IndexedColors.BLACK.index);
		contentStyle.setWrapText(true);	// 字段换行
	}
	
	/**
	 * @Description: 初始化标题行字体
	 */
	private static void initTitleFont(){
		titleFont.setFontName("宋体");
		titleFont.setFontHeightInPoints((short) 20);
		titleFont.setBold(true);;
		titleFont.setCharSet(Font.DEFAULT_CHARSET);
		titleFont.setColor(IndexedColors.BLACK.index);
	}

	

	/**
	 * @Description: 初始化表头行字体
	 */
	private static void initHeadFont() {
		headFont.setFontName("宋体");
		headFont.setFontHeightInPoints((short) 10);
		headFont.setBold(true);
		headFont.setCharSet(Font.DEFAULT_CHARSET);
		headFont.setColor(IndexedColors.BLACK.index);
	}

	/**
	 * @Description: 初始化内容行字体
	 */
	private static void initContentFont() {
		contentFont.setFontName("宋体");
		contentFont.setFontHeightInPoints((short) 10);
		contentFont.setBold(true);
		contentFont.setCharSet(Font.DEFAULT_CHARSET);
		contentFont.setColor(IndexedColors.BLACK.index);
	}
	
	
	/**
	 * @Description: 封装Excel导出的设置信息
	 */
	public static class ExportOrderInfo {
		private List<OrderMaster> orderList;
		private Setting setting;
		private OutputStream out;
		

		public Setting getSetting() {
			return setting;
		}

		public void setSetting(Setting setting) {
			this.setting = setting;
		}

		public OutputStream getOut() {
			return out;
		}

		/**
		 * @param out Excel数据将输出到该输出流
		 */
		public void setOut(OutputStream out) {
			this.out = out;
		}

		

		public List<OrderMaster> getOrderList() {
			return orderList;
		}

		public void setOrderList(List<OrderMaster> orderList) {
			this.orderList = orderList;
		}

		

		
		
		
	}

}
