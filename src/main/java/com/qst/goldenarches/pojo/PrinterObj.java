package com.qst.goldenarches.pojo;

import java.util.List;
import java.util.Map;

public class PrinterObj {
	private boolean flag = true;
	private List<Map<String, Object>> printerList;

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public List<Map<String, Object>> getPrinterList() {
		return printerList;
	}

	public void setPrinterList(List<Map<String, Object>> printerList) {
		this.printerList = printerList;
	}

}
