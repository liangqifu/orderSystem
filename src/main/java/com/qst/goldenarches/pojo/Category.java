package com.qst.goldenarches.pojo;

/**
 * 商品类型表
 */
public class Category extends BasePo {
    /**
     * 商品类型ID
     */
    private int id;
    private int parentId;
    private int printid;
    private String printerName;
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
