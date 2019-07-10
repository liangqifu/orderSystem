package com.qst.goldenarches.pojo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="餐区信息")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Area extends BasePo implements Serializable {

	@ApiModelProperty(value="主键id")
    private Integer id;
    /**
             * 餐区名称
     */
	@ApiModelProperty(value="餐区名称")
    private String name;

	@ApiModelProperty(value="订单信息")
    private List<OrderMaster> orders;
    

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

	public List<OrderMaster> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderMaster> orders) {
		this.orders = orders;
	}
    
    
}

   