package com.qst.goldenarches.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Printer;
import com.qst.goldenarches.service.PrinterService;

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
    @RequestMapping(value= "pagedGetAll",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg pagedGetAll(@RequestParam(value = "pageno",defaultValue = "1") Integer pn, String queryText){
        PageHelper.startPage(pn,5);
        Map<String, Object> param = new HashMap<String,Object>();
        param.put("queryText", queryText);
        List<Printer> list = printerService.query(param);
        com.github.pagehelper.PageInfo<Printer> printerPageInfo =new com.github.pagehelper.PageInfo<Printer>(list,5);
        return Msg.success().add("pageInfo",printerPageInfo);
    }
    
    @RequestMapping("add")
    public String toAdd(){
        return "printer/add";
    }
    
    @ResponseBody
    @RequestMapping(value= "doAdd",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doAdd(@RequestBody Printer printer){
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
    @RequestMapping(value= "doEdit",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doEdit(@RequestBody Printer printer){
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
    
    
}
