/**
 * FileName: ChartController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 14:15
 * Description: 图表跳转控制器
 */
package com.qst.goldenarches.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.service.ChartService;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("chart")
public class ChartController {

    @Autowired
    private ChartService chartService;

    @RequestMapping(value= "/horBarData",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public Msg getSalesAmountOfDay(@RequestBody Map<String, Object> params){
        
        Map<String,Object> datas =chartService.getSalesAmountOfDay(params);
        return Msg.success().add("datas",datas);
    }

    @RequestMapping(value= "/proTypePie",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public Msg getgetEveryProTypePie(@RequestBody Map<String, Object> params){
        List<Map<String,Object>> datas =chartService.getEveryProTypeSaleNum(params);
        return Msg.success().add("chartDatas",datas);
    }

    @RequestMapping(value= "/barData",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public Msg getEveryMonthBarData(@RequestBody Map<String, Object> params){
        //获得当前时间和月份
        Map<String,Object> barData = chartService.getEveryMonthBarData(params);
        return Msg.success().add("barData",barData);
    }

}

