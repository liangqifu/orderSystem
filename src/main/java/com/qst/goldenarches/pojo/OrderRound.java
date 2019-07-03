package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.validation.annotation.Validated;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
@ApiModel(description="每轮订单表")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderRound extends BasePo implements Serializable {
    /**
     * 
     */
	@ApiModelProperty(value="主键id")
    private Integer id;

    /**
          * 第几轮
     */
	@ApiModelProperty(value="第几轮")
    private Integer num;

    /**
     * 订单ID
     */
	@ApiModelProperty(value="订单主表ID")
	@NotNull(message="订单主表ID不能为空")
    private Integer orderId;
    /**
     * 创建时间
     */
	@ApiModelProperty(value="创建时间")
    private Date createTime;
	@ApiModelProperty(value="每轮点餐菜品列表")
	@Valid
	@NotEmpty(message="每轮点餐菜品列表不能为空")
	private List<OrderDetail> orderDetails;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
    
    
}