package com.qst.goldenarches.vo;

import javax.validation.constraints.NotEmpty;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel
public class SignInVo {
	@ApiModelProperty(value="登录密码")
	@NotEmpty
	private String pwd;
	@ApiModelProperty(value="app mac地址")
	@NotEmpty
	private String mac;
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
	
	

}
