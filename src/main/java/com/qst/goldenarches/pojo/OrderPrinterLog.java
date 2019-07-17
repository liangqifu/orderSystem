package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="订单服务信息")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderPrinterLog extends BasePo implements Serializable {
    /**
         * 主键id
     */
	@ApiModelProperty(value="主键id")
    private Integer id;

    /**
       * 订单主表ID
     */
	@ApiModelProperty(value="订单主表ID")
	@NotNull(message="订单主表ID不能为空")
    private Integer orderId;

    /**
            * 服务内容
     */
	@ApiModelProperty(value="服务内容")
    private String content;

    /**
     * 0未打印、1已打印
     */
	@ApiModelProperty(value="0未打印、1已打印",hidden = true)
    private String status;
    /**
            * 创建时间
     */
	@ApiModelProperty(value="创建时间",hidden = true)
    private Date createTime;

    /**
            * 更新时间
     */
	@ApiModelProperty(value="更新时间",hidden = true)
    private Date updateTime;
    
    /**
          * 关联打印机ID
    */
	@ApiModelProperty(value="关联打印机ID")
	@NotNull(message="关联打印机ID不能为空")
    private Integer printerId;
	
	@ApiModelProperty(value="打印失败原因",hidden = true)
	private String msg;

	@ApiModelProperty(value="打印类型：1菜品打印 2酒水打印 3服务打印 4通知付款打印")
	private String pinterType;
    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
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

	public Integer getPrinterId() {
		return printerId;
	}

	public void setPrinterId(Integer printerId) {
		this.printerId = printerId;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPinterType() {
		return pinterType;
	}

	public void setPinterType(String pinterType) {
		this.pinterType = pinterType;
	}
    
    
}