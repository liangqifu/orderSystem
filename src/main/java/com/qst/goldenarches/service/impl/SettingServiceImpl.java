package com.qst.goldenarches.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.dao.SettingMapper;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.SettingService;
@Service
public class SettingServiceImpl implements SettingService {
	@Autowired
	private SettingMapper settingMapper;

	@Override
	public Setting getSettingInfo() {
		return settingMapper.getSettingInfo();
	}
	

}
