package com.qst.goldenarches.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.Printer;

public interface PrinterMapper {
	
	public int insert(Printer printer);
	public int update(Printer printer);
    public Printer getById(Integer id);
    public List<Printer> query(Printer printer);
    
    public void deleteById(Integer id);
	public int ckExitIp(@Param("ip")String ip);

}
