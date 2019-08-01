package com.qst.goldenarches.vo;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.qst.goldenarches.pojo.BasePo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="订单明细")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderDetailVo extends BasePo implements Serializable {
    
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 397961460721652115L;

	@ApiModelProperty(value="明细类型 1 酒水类明细 2菜品类明细 3服务类明细")
	@NotNull(message="明细类型 1 酒水类明细 2菜品类明细 3服务类明细不能为空")
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

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
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

    
}