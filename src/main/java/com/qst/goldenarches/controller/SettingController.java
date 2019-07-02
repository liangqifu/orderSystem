package com.qst.goldenarches.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.AreaService;
import com.qst.goldenarches.service.SettingService;

import springfox.documentation.annotations.ApiIgnore;


@ApiIgnore
@Controller
@RequestMapping("/setting")
public class SettingController {
	@Autowired
	private SettingService settingService;
	@Autowired
	private AreaService areaService;
	
	
	@ResponseBody
    @RequestMapping(value= "info",method=RequestMethod.GET)
    public Msg getSetting(){
        return Msg.success().add("settingInfo",settingService.getSettingInfo());
    }
	@ApiIgnore
	@ResponseBody
    @RequestMapping(value= "/save",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg save(@RequestBody Setting setting){
    	 try {
    		 if(setting.getId()>0) {
    			 settingService.update(setting);
    	     }else {
    	    	 settingService.insert(setting);
    	      }
         }catch (Exception e){
             e.printStackTrace();
             return Msg.fail();
         }
         return Msg.success();
    }
	@ApiIgnore
	@RequestMapping("index")
    public String toIndex(){
        return "setting/index";
    }
	@ApiIgnore
	@ResponseBody
    @RequestMapping(value= "queryAreaList",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryAreaList(@RequestBody Area area){
        PageHelper.startPage(area.getPageNum(),area.getPageSize());
        List<Area> list = areaService.query(area);
        com.github.pagehelper.PageInfo<Area> printerPageInfo = new com.github.pagehelper.PageInfo<Area>(list,area.getPageSize());
        return Msg.success().add("data",printerPageInfo);
    }
	@ApiIgnore
	@ResponseBody
    @RequestMapping(value= "/area/save",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg saveArea(@RequestBody Area area){
    	 try {
    		 if(area.getId()>0) {
    			areaService.update(area);
    	     }else {
    	    	areaService.insert(area);
    	      }
         }catch (Exception e){
             e.printStackTrace();
             return Msg.fail();
         }
         return Msg.success();
    }
	

}
