package com.qst.goldenarches.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Printer;
import com.qst.goldenarches.service.PrinterService;
import com.qst.goldenarches.utils.DigitalUtil;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("/printer")
public class PrinterController {
	@Autowired
	private  PrinterService printerService;
	
    @RequestMapping("index")
    public String toIndex(){
        return "printer/index";
    }
    
    @ResponseBody
    @RequestMapping(value= "queryListByPage",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryListByPage(@RequestBody Printer printer ){
    	PageHelper.startPage(printer.getPageNum(),printer.getPageSize());
        List<Printer> list = printerService.query(printer);
        for (Printer p : list) {
			if(!StringUtils.isEmpty(p.getIp())) {
				if(DigitalUtil.isHostReachable(p.getIp(), 1000)) {
					p.setOnLine("1");
				}else {
					p.setOnLine("0");
				}
			}
		}
        com.github.pagehelper.PageInfo<Printer> printerPageInfo = new com.github.pagehelper.PageInfo<Printer>(list,printer.getPageSize());
        return Msg.success().add("data",printerPageInfo);
    }
    
    
    @ResponseBody
    @RequestMapping(value= "getList",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryList(@RequestBody Printer printer){
        List<Printer> list = printerService.query(printer);
        return Msg.success().add("data",list);
    }
    
    @RequestMapping("add")
    public String toAdd(){
        return "printer/add";
    }
    
    @ResponseBody
    @RequestMapping(value= "insert",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg insert(@RequestBody Printer printer){
    	int count = printerService.ckExitIp(printer.getIp());
    	if(count >0) {
    		Msg result =new Msg();
            result.setCode(200);
            result.setMsg("IP已存在，请重新输入");
            return result;
    	}
        Boolean flag =printerService.add(printer);
        if (flag){
            return Msg.success().add("printer",printer);
        }
        return Msg.fail();
    }
    
    @RequestMapping("edit")
    public String toEdit(Printer printer, Model model){
    	printer = printerService.getById(printer.getId());
        model.addAttribute("printer", printer);
        return "printer/edit";
    }
    
    @ResponseBody
    @RequestMapping(value= "update",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg update(@RequestBody Printer printer){
        try {
        	Printer printerOld = printerService.getById(printer.getId());
        	if(!printerOld.getIp().equals(printer.getIp())) {
        		int count = printerService.ckExitIp(printer.getIp());
            	if(count >0) {
            		Msg result =new Msg();
                    result.setCode(200);
                    result.setMsg("IP已存在，请重新输入");
                    return result;
            	}
        	}
            if(!printerService.edit(printer)){
            	return Msg.fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success().add("printer",printer);
    }
    
    @ResponseBody
    @RequestMapping(value= "save",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg save(@RequestBody Printer printer){
        if(printer.getId() > 0) {
        	return this.update(printer);
        }else {
        	return this.insert(printer);
        }
    }
    
    
}
