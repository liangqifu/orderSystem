package com.qst.goldenarches.pojo;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
@ApiModel(description="打印机信息")
public class Printer extends BasePo {
	@ApiModelProperty(value="主键ID")
	
	private int id;
	@ApiModelProperty(value="打印机名称")
	private String name;
	@ApiModelProperty(value="打印机IP地址")
	private String ip;
	@ApiModelProperty(value="打印机端口")
	private Integer port;
	@ApiModelProperty(value="状态1可用 0 不可用")
    private String status;
	@ApiModelProperty(value="是否在线")
    private String onLine;
    private int rowNo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOnLine() {
		return onLine;
	}
	public void setOnLine(String onLine) {
		this.onLine = onLine;
	}
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public Integer getPort() {
		return port;
	}
	public void setPort(Integer port) {
		this.port = port;
	}
    
	
    
}
