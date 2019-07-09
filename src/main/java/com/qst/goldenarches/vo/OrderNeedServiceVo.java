package com.qst.goldenarches.vo;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.qst.goldenarches.pojo.OrderDetail;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="需求服务接口参数")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderNeedServiceVo {
	@ApiModelProperty(value="订单ID")
	@NotNull(message="订单ID不能为空")
	private Integer orderId;
	@ApiModelProperty(value="服务详情")
    private List<OrderDetail> needServiceDetails;
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public List<OrderDetail> getNeedServiceDetails() {
		return needServiceDetails;
	}
	public void setNeedServiceDetails(List<OrderDetail> needServiceDetails) {
		this.needServiceDetails = needServiceDetails;
	}
	
}
