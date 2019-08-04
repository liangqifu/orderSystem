package com.qst.goldenarches.pojo;

import java.util.List;
import java.util.Map;

public class PrinterObj {
	private boolean flag = true;
	private Map<String, List<OrderDetail>>  printerMap;

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public Map<String, List<OrderDetail>> getPrinterMap() {
		return printerMap;
	}

	public void setPrinterMap(Map<String, List<OrderDetail>> printerMap) {
		this.printerMap = printerMap;
	}

	

}
