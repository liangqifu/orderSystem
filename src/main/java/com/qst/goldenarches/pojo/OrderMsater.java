package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="订单主表")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderMsater extends BasePo implements Serializable {
    /**
             * 订单id
     */
	@ApiModelProperty(value="订单id")
    private Integer orderId;

    /**
     * 餐区ID
     */
	@ApiModelProperty(value="餐区ID")
	@NotNull(message="餐区ID不能为空")
    private Integer buyerId;

    /**
     * 订单类型 1午餐 2晚餐
     */
	@ApiModelProperty(value="订单类型 1午餐 2晚餐")
	@NotEmpty(message="订单类型不能为空")
    private String orderType;

    /**
     * 订单总金额
     */
	@ApiModelProperty(value="订单总金额")
    private Double totalAmount;

    /**
     * 台号
     */
	@ApiModelProperty(value="台号")
	@NotEmpty(message="台号不能为空")
    private String tableNum;

    /**
     * 成年人数
     */
	@ApiModelProperty(value="成年人数")
    private Integer adult;

    /**
     * 小孩人数
     */
	@ApiModelProperty(value="小孩人数")
    private Integer child;

    /**
     * 每轮午餐能点的数量
     */
	@ApiModelProperty(value="每轮午餐能点的数量")
	@NotNull(message="每轮午餐能点的数量不能为空")
    private Integer lunchNum;

    /**
     * 每轮晚餐能点的数量
     */
	@ApiModelProperty(value="每轮晚餐能点的数量")
	@NotNull(message="每轮晚餐能点的数量不能为空")
    private Integer dinnerNum;

    /**
           * 每轮需要等的时间
     */
	@ApiModelProperty(value="每轮需要等的时间")
	@NotNull(message="每轮需要等的时间不能为空")
    private Integer waitTime;

    /**
     * 订单状态 0未结账 1已结账
     */
	@ApiModelProperty(value="订单状态 0未结账 1已结账 已取消")
    private String status;

    /**
     * 开台时间
     */
	@ApiModelProperty(value="开台时间")
    private Date openTime;

    /**
     * 创建时间
     */
	@ApiModelProperty(value="创建时间",hidden=true)
    private Date createTime;
	/**
	 * 更新时间
	 */
	@ApiModelProperty(value="更新时间",hidden=true)
	private Date updateTime;
	
	@ApiModelProperty(value="每轮点餐列表")
	private List<OrderRound> orderRounds;
	
	

    private static final long serialVersionUID = 1L;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(Integer buyerId) {
        this.buyerId = buyerId;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType == null ? null : orderType.trim();
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getTableNum() {
        return tableNum;
    }

    public void setTableNum(String tableNum) {
        this.tableNum = tableNum == null ? null : tableNum.trim();
    }

    public Integer getAdult() {
        return adult;
    }

    public void setAdult(Integer adult) {
        this.adult = adult;
    }

    public Integer getChild() {
        return child;
    }

    public void setChild(Integer child) {
        this.child = child;
    }

    public Integer getLunchNum() {
        return lunchNum;
    }

    public void setLunchNum(Integer lunchNum) {
        this.lunchNum = lunchNum;
    }

    public Integer getDinnerNum() {
        return dinnerNum;
    }

    public void setDinnerNum(Integer dinnerNum) {
        this.dinnerNum = dinnerNum;
    }

    public Integer getWaitTime() {
        return waitTime;
    }

    public void setWaitTime(Integer waitTime) {
        this.waitTime = waitTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Date openTime) {
        this.openTime = openTime;
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

	public List<OrderRound> getOrderRounds() {
		return orderRounds;
	}

	public void setOrderRounds(List<OrderRound> orderRounds) {
		this.orderRounds = orderRounds;
	}

    
}