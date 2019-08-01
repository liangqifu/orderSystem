package com.qst.goldenarches.pojo;

import com.alibaba.fastjson.JSON;
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
    private Integer parentId;
	@ApiModelProperty(value="关联打印机ID",hidden=true)
    private Integer printid;
	@ApiModelProperty(value="关联打印机",hidden=true)
	private Printer printer;
	@ApiModelProperty(value="分类名称")
    private String name;
	@ApiModelProperty(value="图片")
    private String pic;
	@ApiModelProperty(value="打印类型 0批量 1单个")
    private String printType;
	

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
    

   
	

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getPrintid() {
		return printid;
	}

	public void setPrintid(Integer printid) {
		this.printid = printid;
	}

	

	public Printer getPrinter() {
		return printer;
	}

	public void setPrinter(Printer printer) {
		this.printer = printer;
	}

	@Override
    public String toString() {
        return JSON.toJSONString(this);
    }

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getPrintType() {
		return printType;
	}

	public void setPrintType(String printType) {
		this.printType = printType;
	}
	
	
	
}
