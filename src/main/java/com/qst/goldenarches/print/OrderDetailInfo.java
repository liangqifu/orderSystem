package com.qst.goldenarches.print;

public class OrderDetailInfo {
     /**
     * 数量
     */
    private Integer number;
    
    /**
     * 菜品编号
     */
    private String productNo;
    /**
     * 菜品名称
     */
    private String productName;
    
    /**
     * 单价
     */
    private Double price;
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
    
    
}
