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
    private int id;
    /**
     * 商品名
     */
	@ApiModelProperty(value="菜品名称")
    private String name;
    /**
     * 商品单价
     */
	@ApiModelProperty(value="单价")
    private double price;
    /**
     * 商品库存
     */
	@ApiModelProperty(value="库存")
    private int inventory;
    /**
     * 商品状态
     */
	@ApiModelProperty(value="状态 1上架 0下架")
    private int status;
    /**
     * 商品类型id
     */
	@ApiModelProperty(value="菜品类型ID")
    private int cid;
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
    /**
     * 商品图片
     */
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
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

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", inventory=" + inventory +
                ", status=" + status +
                ", cid=" + cid +
                ", category=" + category +
                ", pic='" + pic + '\'' +
                '}';
    }
}
