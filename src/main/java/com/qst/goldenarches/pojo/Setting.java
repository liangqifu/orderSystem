package com.qst.goldenarches.pojo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
@ApiModel(description="系统设置")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Setting implements Serializable {
	private static final long serialVersionUID = 1L;
    /**
     * 
     */
	@ApiModelProperty(value="主键ID")
    private Integer id;

    /**
     * app开机密码
     */
	@ApiModelProperty(value="app开机密码")
    private String appPwd;

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
	 /**
          * 每位成人午餐价格
     */
	@ApiModelProperty(value="每位成人午餐价格")
    private Double adultLunchPrice;
	 /**
	     * 每位成人晚餐价格
	*/
	@ApiModelProperty(value="每位成人晚餐价格")
	private Double adultDinnerPrice;
	 /**
         * 每位小孩午餐价格
     */
	@ApiModelProperty(value="每位小孩午餐价格")
    private Double childLunchPrice;
	 /**
	     * 每位小孩晚餐价格
	 */
	@ApiModelProperty(value="每位小孩晚餐价格")
	private Double childDinnerPrice;
    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAppPwd() {
        return appPwd;
    }

    public void setAppPwd(String appPwd) {
        this.appPwd = appPwd == null ? null : appPwd.trim();
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

	public Double getAdultLunchPrice() {
		return adultLunchPrice;
	}

	public void setAdultLunchPrice(Double adultLunchPrice) {
		this.adultLunchPrice = adultLunchPrice;
	}

	public Double getAdultDinnerPrice() {
		return adultDinnerPrice;
	}

	public void setAdultDinnerPrice(Double adultDinnerPrice) {
		this.adultDinnerPrice = adultDinnerPrice;
	}

	public Double getChildLunchPrice() {
		return childLunchPrice;
	}

	public void setChildLunchPrice(Double childLunchPrice) {
		this.childLunchPrice = childLunchPrice;
	}

	public Double getChildDinnerPrice() {
		return childDinnerPrice;
	}

	public void setChildDinnerPrice(Double childDinnerPrice) {
		this.childDinnerPrice = childDinnerPrice;
	}

	
    
}