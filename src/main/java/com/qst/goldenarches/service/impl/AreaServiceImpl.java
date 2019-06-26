package com.qst.goldenarches.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.dao.AreaMapper;
import com.qst.goldenarches.service.AreaService;
@Service
public class AreaServiceImpl implements AreaService {
    @Autowired 
	private AreaMapper areaMapper;
}
