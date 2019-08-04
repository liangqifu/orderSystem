package com.qst.goldenarches.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.AreaService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.utils.ImageUtil;

import springfox.documentation.annotations.ApiIgnore;


@ApiIgnore
@Controller
@RequestMapping("/setting")
public class SettingController {
	private static Logger logger = LogManager.getLogger(SettingController.class);
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
    @RequestMapping(value= "updateLanguage",method=RequestMethod.POST,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg updateLanguage(@RequestParam("language")String language,HttpServletRequest request){
    	 try {
    		 Setting setting = settingService.getSettingInfo();
    		 if(setting != null) {
    			 Setting updateSetting = new Setting();
    			 updateSetting.setId(setting.getId());
    			 updateSetting.setLanguage(language);
    			 settingService.update(updateSetting);
    		 }
         }catch (Exception e){
        	 logger.error("updateLanguage Exception",e);
             return Msg.fail();
         }
         return Msg.success();
    }
	@ApiIgnore
	@ResponseBody
    @RequestMapping(value= "save",method=RequestMethod.POST,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg save(Setting setting,HttpServletRequest request){
    	 try {
    		 MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
             MultipartFile mFile = multipartRequest.getFile("logoPic");
             if (!StringUtils.isEmpty(mFile.getOriginalFilename())){
                 String img = ImageUtil.upload(request,"logo",mFile);
                 if (!StringUtils.isEmpty(img)) {
                	 setting.setLogo(img);
                 }
             }
    		 if(setting.getId()>0) {
    			 if(!StringUtils.isEmpty(setting.getLogo())) {
    				 Setting settingtDB = settingService.getSettingInfo();
 					if(!StringUtils.isEmpty(settingtDB.getLogo())) {
 						ImageUtil.dropPic(request,"logo",settingtDB.getLogo());
 					}
 				}
    			settingService.update(setting);
    	     }else {
    	    	 settingService.insert(setting);
    	      }
         }catch (Exception e){
        	 logger.error("save Exception",e);
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
        try {
			PageHelper.startPage(area.getPageNum(),area.getPageSize());
			List<Area> list = areaService.query(area);
			com.github.pagehelper.PageInfo<Area> printerPageInfo = new com.github.pagehelper.PageInfo<Area>(list,area.getPageSize());
			return Msg.success().add("data",printerPageInfo);
		} catch (Exception e) {
			 logger.error("queryAreaList Exception",e);
             return Msg.fail();
		}
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
        	 logger.error("/area/save Exception",e);
             return Msg.fail();
         }
         return Msg.success();
    }
	

}
