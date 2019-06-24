package com.qst.goldenarches.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.SettingService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;


@Api(value="系统设置")
@Controller
@RequestMapping("/setting")
public class SettingController {
	@Autowired
	private SettingService settingService;
	
	@ApiOperation(value="获取系统设置信息",response=Setting.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "info",method=RequestMethod.GET)
    public Msg getSetting(){
        return Msg.success().add("settingInfo",settingService.getSettingInfo());
    }

}
