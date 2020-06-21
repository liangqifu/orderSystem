package com.qst.goldenarches.print;

import java.math.BigDecimal;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class OrderInfo {
	/**
	* 台号
	*/
	private String tableNum;
	/**
	 * 日期
	 */
	private String date;
	/**
	 * 时间
	 */
	private String time;
	/**
	 * 餐区
	 */
	private String area;
	
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 打印明细
	 */
	private List<OrderDetailInfo> detailInfos;
	@JSONField(format = "##.##")
	private BigDecimal totalAmount;
	
	private String printType;
	
	
	public String getTableNum() {
		return tableNum;
	}
	public void setTableNum(String tableNum) {
		this.tableNum = tableNum;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public List<OrderDetailInfo> getDetailInfos() {
		return detailInfos;
	}
	public void setDetailInfos(List<OrderDetailInfo> detailInfos) {
		this.detailInfos = detailInfos;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPrintType() {
		return printType;
	}
	public void setPrintType(String printType) {
		this.printType = printType;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	
}
