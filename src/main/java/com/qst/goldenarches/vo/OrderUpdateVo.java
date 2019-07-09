package com.qst.goldenarches.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.qst.goldenarches.pojo.BasePo;
import com.qst.goldenarches.pojo.OrderRound;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="更新订单信息")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderUpdateVo  implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -687312530233095087L;

	/**
             * 订单id
     */
	@ApiModelProperty(value="订单id")
	@NotNull(message="订单id")
    private Integer orderId;

    /**
     * 餐区ID
     */
	@ApiModelProperty(value="餐区ID")
    private Integer buyerId;

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
    private Integer lunchNum;

    /**
     * 每轮晚餐能点的数量
     */
	@ApiModelProperty(value="每轮晚餐能点的数量")
    private Integer dinnerNum;

    /**
           * 每轮需要等的时间
     */
	@ApiModelProperty(value="每轮需要等的时间")
    private Integer waitTime;

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

	public String getTableNum() {
		return tableNum;
	}

	public void setTableNum(String tableNum) {
		this.tableNum = tableNum;
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


    
}