package com.qst.goldenarches.service;

import java.util.List;

import com.qst.goldenarches.pojo.Area;

public interface AreaService {

	List<Area> query(Area area);

	void update(Area area);

	void insert(Area area);

}
