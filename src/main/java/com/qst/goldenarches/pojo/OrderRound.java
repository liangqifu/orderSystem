package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.Date;

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
    private Integer orderId;

    /**
     * 创建时间
     */
	@ApiModelProperty(value="创建时间")
    private Date createTime;

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
}