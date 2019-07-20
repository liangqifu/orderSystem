package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="订单明细")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderDetail extends BasePo implements Serializable {
    

	/**
       * 订单详情表id
     */
	@ApiModelProperty(value="订单详情表id")
    private Integer detailId;
	private List<Integer> detailIds;
	
	@ApiModelProperty(value="明细类型 1 酒水类明细 2菜品类明细 3服务类明细")
	@NotNull(message="明细类型 1 酒水类明细 2菜品类明细 3服务类明细 不能为空")
	private String detailType;

    /**
            * 订单总表id
     */
	@ApiModelProperty(value="订单主表id")
	@NotNull(message="订单主表id不能为空")
    private Integer orderId;

    /**
     * 点餐轮数id
     */
	@ApiModelProperty(value="点餐轮数id")
    private Integer roundId;

    /**
     * 商品id
     */
	@ApiModelProperty(value="菜品ID")
	@NotNull(message="菜品ID不能为空")
    private Integer productId;

    /**
     * 商品�?
     */
	@ApiModelProperty(value="菜品名称")
	@NotNull(message="菜品名称不能为空")
    private String productName;

    /**
     * 
     */
	@ApiModelProperty(value="菜品单价")
	@NotNull(message="菜品单价不能为空")
    private Double productPrice;

    /**
     * 商品数量
     */
	@ApiModelProperty(value="菜品数量")
	@NotNull(message="菜品数量不能为空")
    private Integer productNumber;

    /**
     * 分类id
     */
	@ApiModelProperty(value="菜品分类ID")
	@NotNull(message="菜品分类ID不能为空")
    private Integer categoryId;

    /**
     * 分类名称
     */
	@ApiModelProperty(value="菜品分类名称")
	@NotNull(message="菜品分类名称不能为空")
    private String categoryName;
  
    /**
     * 创建时间
     */
	@ApiModelProperty(value="创建时间")
    private Date createTime;

    /**
     * 修改时间
     */
	@ApiModelProperty(value="修改时间")
    private Date updateTime;

    private static final long serialVersionUID = 1L;

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getRoundId() {
        return roundId;
    }

    public void setRoundId(Integer roundId) {
        this.roundId = roundId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductNumber() {
        return productNumber;
    }

    public void setProductNumber(Integer productNumber) {
        this.productNumber = productNumber;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }


    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}

	public List<Integer> getDetailIds() {
		return detailIds;
	}

	public void setDetailIds(List<Integer> detailIds) {
		this.detailIds = detailIds;
	}

    
    
}