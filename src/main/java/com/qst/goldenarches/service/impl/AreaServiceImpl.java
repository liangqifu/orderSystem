package com.qst.goldenarches.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.dao.AreaMapper;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.service.AreaService;
@Service
public class AreaServiceImpl implements AreaService {
    @Autowired 
	private AreaMapper areaMapper;

	@Override
	public List<Area> query(Area area) {
		return areaMapper.query(area);
	}

	@Override
	public void update(Area area) {
		areaMapper.updateByPrimaryKeySelective(area);
		
	}

	@Override
	public void insert(Area area) {
		areaMapper.insert(area);
	}
}
