package com.qst.goldenarches.dao;

import java.util.List;
import java.util.Map;

import com.qst.goldenarches.pojo.Printer;

public interface PrinterMapper {
	
	public int insert(Printer printer);
	public int update(Printer printer);
    public Printer getById(Integer id);
    public List<Printer> query(Map<String, Object> param);
    
    public void deleteById(Integer id);

}
