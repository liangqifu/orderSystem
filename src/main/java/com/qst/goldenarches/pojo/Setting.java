package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;
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
	@ApiModelProperty(value="控制面板App登录密码")
    private String ctlAppPwd;
	@ApiModelProperty(value="取消订单密码")
    private String cancelPwd;
	
	@ApiModelProperty(value="app端logo图片")
    private String logo;
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
	@JSONField(format = "##.##")
    private BigDecimal adultLunchPrice;
	 /**
	     * 每位成人晚餐价格
	*/
	@ApiModelProperty(value="每位成人晚餐价格")
	@JSONField(format = "##.##")
	private BigDecimal adultDinnerPrice;
	 /**
         * 每位小孩午餐价格
     */
	@ApiModelProperty(value="每位小孩午餐价格")
	@JSONField(format = "##.##")
    private BigDecimal childLunchPrice;
	 /**
	     * 每位小孩晚餐价格
	 */
	@ApiModelProperty(value="每位小孩晚餐价格")
	@JSONField(format = "##.##")
	private BigDecimal childDinnerPrice;
	
	 /**
             * 服务台打印机id
     */
	@ApiModelProperty(value="服务台打印机id",hidden =true)
    private Integer servicePrinterId;
	@ApiModelProperty(value="服务台打印机",hidden =true)
	private Printer servicePrinter;
	
	@ApiModelProperty(value="语言",hidden =true)
	/**
	 * 语言
	 */
	private String language;
    

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

	public BigDecimal getAdultLunchPrice() {
		return adultLunchPrice;
	}

	public void setAdultLunchPrice(BigDecimal adultLunchPrice) {
		this.adultLunchPrice = adultLunchPrice;
	}

	public BigDecimal getAdultDinnerPrice() {
		return adultDinnerPrice;
	}

	public void setAdultDinnerPrice(BigDecimal adultDinnerPrice) {
		this.adultDinnerPrice = adultDinnerPrice;
	}

	public BigDecimal getChildLunchPrice() {
		return childLunchPrice;
	}

	public void setChildLunchPrice(BigDecimal childLunchPrice) {
		this.childLunchPrice = childLunchPrice;
	}

	public BigDecimal getChildDinnerPrice() {
		return childDinnerPrice;
	}

	public void setChildDinnerPrice(BigDecimal childDinnerPrice) {
		this.childDinnerPrice = childDinnerPrice;
	}

	public Integer getServicePrinterId() {
		return servicePrinterId;
	}

	public void setServicePrinterId(Integer servicePrinterId) {
		this.servicePrinterId = servicePrinterId;
	}

	public String getCtlAppPwd() {
		return ctlAppPwd;
	}

	public void setCtlAppPwd(String ctlAppPwd) {
		this.ctlAppPwd = ctlAppPwd;
	}

	public Printer getServicePrinter() {
		return servicePrinter;
	}

	public void setServicePrinter(Printer servicePrinter) {
		this.servicePrinter = servicePrinter;
	}

	public String getCancelPwd() {
		return cancelPwd;
	}

	public void setCancelPwd(String cancelPwd) {
		this.cancelPwd = cancelPwd;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	
    
}