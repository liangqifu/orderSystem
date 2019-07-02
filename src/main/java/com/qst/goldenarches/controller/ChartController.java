/**
 * FileName: ChartController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 14:15
 * Description: 图表跳转控制器
 */
package com.qst.goldenarches.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @RequestMapping("horBarData")
    @ResponseBody
    public Msg getSalesAmountOfDay(String date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (date==null||"".equals(date)){
            date=sdf.format(new Date());
        }
        Map<String,Object> datas =chartService.getSalesAmountOfDay(date);
        return Msg.success().add("datas",datas);
    }

    @RequestMapping("proTypePie")
    @ResponseBody
    public Msg getgetEveryProTypePie(){
        List<Map> datas =chartService.getEveryProTypeSaleNum();
        return Msg.success().add("chartDatas",datas);
    }

    @RequestMapping("barData")
    @ResponseBody
    public Msg getEveryMonthBarData(){
        //获得当前时间和月份
        Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1;
        int year =calendar.get(Calendar.YEAR);
        Map<String,Object> barData =chartService.getEveryMonthBarData(year,month);
        return Msg.success().add("barData",barData);
    }

}

