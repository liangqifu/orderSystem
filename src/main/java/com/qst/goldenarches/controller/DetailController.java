/**
 * FileName: DetailController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 8:54
 * Description: 后台：订单详情控制器
 */
package com.qst.goldenarches.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.service.DetailService;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("detail")
public class DetailController {

    @Autowired
    private DetailService detailService;

    @ResponseBody
    @RequestMapping("orderIdDetails")
    public Msg getDetailsByOid(Integer id){
        List<Detail> details =detailService.getDetailsByOid(id);
        return Msg.success().add("details",details);
    }
}
