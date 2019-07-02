package com.qst.goldenarches.service.impl;

import java.util.List;

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
	public List<Printer> query(Printer printer) {
		return printerMapper.query(printer);
	}
	@Override
	public Boolean add(Printer printer) {
		printer.setStatus("0");
		return printerMapper.insert(printer)==1?true:false;
	}
	@Override
	public Printer getById(int id) {
		return printerMapper.getById(id);
	}
	@Override
	public boolean edit(Printer printer) {
		return printerMapper.update(printer)==1?true:false;
	}
	@Override
	public int ckExitIp(String ip) {
		return printerMapper.ckExitIp(ip);
	}

}
