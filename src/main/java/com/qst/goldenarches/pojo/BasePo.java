package com.qst.goldenarches.pojo;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModelProperty;
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BasePo {
	@ApiModelProperty(value="第几页")
	private int pageNum = 1;
	@ApiModelProperty(value="每页显示数量")
	private int pageSize = 10;
	@ApiModelProperty(value="删除状态 0正常 1删除",hidden=true)
	private String state;
	@ApiModelProperty(value="模糊查询参数")
	private String searchKey;

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	
	
	
	

}
