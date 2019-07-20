package com.qst.goldenarches.vo;

import javax.validation.constraints.NotEmpty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(description="app登录参数")
public class SignInVo {
	@ApiModelProperty(value="登录密码")
	@NotEmpty
	private String pwd;
	@ApiModelProperty(value="app mac地址")
	@NotEmpty
	private String mac;
	@ApiModelProperty(value="登录类型 1客户端App登录 2 控制面板登录")
	@NotEmpty
	private String type;
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	

}
