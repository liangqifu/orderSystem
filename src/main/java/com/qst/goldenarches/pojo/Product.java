package com.qst.goldenarches.pojo;

import com.fasterxml.jackson.annotation.JsonInclude;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 商品表
 */
@ApiModel(description="菜品信息")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Product extends BasePo {
    /**
     * 商品id
     */
	@ApiModelProperty(value="主键ID")
    private Integer id;
    /**
     * 商品名
     */
	@ApiModelProperty(value="菜品名称")
    private String name;
	@ApiModelProperty(value="菜品编号")
    private String no;
    /**
     * 商品单价
     */
	@ApiModelProperty(value="单价")
    private double price;
    /**
     * 商品库存
     */
	@ApiModelProperty(value="库存")
    private Integer inventory;
    /**
     * 商品状态
     */
	@ApiModelProperty(value="状态 1上架 0下架")
    private String status;
    /**
     * 商品类型id
     */
	@ApiModelProperty(value="菜品类型ID")
    private Integer cid;
	@ApiModelProperty(value="菜品类型ID",hidden=true)
    private Integer keyCid;
    /**
     * 商品类型id
     */
	@ApiModelProperty(value="菜品类型")
    private Category category;
    /**
     * 商品类型对象
     */
	@ApiModelProperty(value="菜品图片")
    private String pic;
	@ApiModelProperty(value="1午餐,2晚餐")
	private String type;
	@ApiModelProperty(value="是否午餐菜 0 否 1 是")
	private String type1;
	@ApiModelProperty(value="是否晚餐菜 0 否 1 是")
	private String type2;
    /**
     * 商品图片
     */
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
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

	public Integer getKeyCid() {
		return keyCid;
	}

	public void setKeyCid(Integer keyCid) {
		this.keyCid = keyCid;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getType1() {
		return type1;
	}

	public void setType1(String type1) {
		this.type1 = type1;
	}

	public String getType2() {
		return type2;
	}

	public void setType2(String type2) {
		this.type2 = type2;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	
	

    
}
