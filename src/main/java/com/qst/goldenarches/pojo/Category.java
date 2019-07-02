package com.qst.goldenarches.pojo;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 商品类型表
 */
@ApiModel(description="菜品分类")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Category extends BasePo {
    /**
     * 商品类型ID
     */
	@ApiModelProperty(value="主键ID")
    private int id;
	@ApiModelProperty(value="父级ID")
    private int parentId;
	@ApiModelProperty(value="关联打印机ID")
    private int printid;
	@ApiModelProperty(value="关联打印机名称")
    private String printerName;
	@ApiModelProperty(value="关联打印机IP地址")
    private String printIp;
    /**
     * 商品类型名
     */
    private String name;

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
    

    public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	
	public int getPrintid() {
		return printid;
	}

	public void setPrintid(int printid) {
		this.printid = printid;
	}
	
	

	public String getPrintIp() {
		return printIp;
	}

	public void setPrintIp(String printIp) {
		this.printIp = printIp;
	}
	

	public String getPrinterName() {
		return printerName;
	}

	public void setPrinterName(String printerName) {
		this.printerName = printerName;
	}

	@Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
