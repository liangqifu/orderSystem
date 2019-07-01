package com.qst.goldenarches.service;

import java.util.List;
import java.util.Map;

import com.qst.goldenarches.pojo.Printer;

public interface PrinterService {

	List<Printer> query(Printer printer);

	Boolean add(Printer printer);

	Printer getById(int id);

	boolean edit(Printer printer);

	int ckExitIp(String ip);

}
