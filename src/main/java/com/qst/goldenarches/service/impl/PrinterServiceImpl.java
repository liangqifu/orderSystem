package com.qst.goldenarches.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.dao.PrinterMapper;
import com.qst.goldenarches.pojo.Printer;
import com.qst.goldenarches.service.PrinterService;
@Service
public class PrinterServiceImpl implements PrinterService {
	@Autowired
	private PrinterMapper printerMapper;
	@Override
	public List<Printer> query(Map<String, Object> param) {
		return printerMapper.query(param);
	}
	@Override
	public Boolean add(Printer printer) {
		printer.setStatus("0");
		return printerMapper.insert(printer)==1?true:false;
	}

}
