package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Setting;

public interface SettingService {

	Setting getSettingInfo();

	void update(Setting setting);

	void insert(Setting setting);

}
