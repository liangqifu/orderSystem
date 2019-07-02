package com.qst.goldenarches.pojo;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="餐区信息")
public class Area extends BasePo implements Serializable {
    /**
     * 
     */
	@ApiModelProperty(value="主键id")
    private Integer id;

    /**
     * 餐区名称
     */
	@ApiModelProperty(value="餐区名称")
    private String name;

    /**
     * 餐区密码
     */
	@ApiModelProperty(value="餐区密码",hidden=true)
    private String pwd;
    
    

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

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }
}