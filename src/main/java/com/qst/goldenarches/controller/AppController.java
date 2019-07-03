package com.qst.goldenarches.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.exception.BusException;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMsater;
import com.qst.goldenarches.pojo.OrderPrinterLog;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.AreaService;
import com.qst.goldenarches.service.CategoryService;
import com.qst.goldenarches.service.OrderService;
import com.qst.goldenarches.service.ProductService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.vo.SignInVo;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api(value="app接口",description="App接口文档")
@Controller
@RequestMapping("/app")
public class AppController {
	static Logger logger = LogManager.getLogger(AppController.class);
	
	@Autowired
	private SettingService settingService;
	@Autowired
	private AreaService areaService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
    private ProductService productService;
	@Autowired
    private OrderService orderService;
	
	
	
	@ApiOperation(value="App登录接口",response=Setting.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/signin",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg signin(@RequestBody @Validated SignInVo vo){
		Setting setting = settingService.getSettingInfo();
		if(setting == null) {
			return Msg.fail("系统未授权App登录");
		}
		if(!vo.getPwd().equals(setting.getAppPwd())) {
			return Msg.fail("登录密码不正确");
		}
		Category category = new Category();
		category.setState("0");
		Area area = new Area();
		area.setState("0");
        return Msg.success().add("setting",setting)
        		.add("categorys", categoryService.query(category))
        		.add("areas", areaService.query(area));
    }
	
	@ApiOperation(value="分页查询菜品列表",response=Product.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/product/queryListByPage",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryProductListByPage(@RequestBody @Validated Product product,HttpServletRequest request){
		PageHelper.startPage(product.getPageNum(),product.getPageSize());
		product.setStatus(1);
        List<Product> list = productService.query(product);
        com.github.pagehelper.PageInfo<Product> pageInfo = new com.github.pagehelper.PageInfo<Product>(list,product.getPageSize());
        String imgPath = request.getServletContext().getContextPath()+"/img/product/";
        return Msg.success().add("data",pageInfo).add("imgPath", imgPath);
    }
	
	@ApiOperation(value="午餐/晚餐确认,",response=OrderMsater.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/confirm",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg createOrderMaster(@RequestBody @Validated OrderMsater order){
		try {
			orderService.createOrderMaster(order);
		} catch (Exception e) {
			logger.error("午餐/晚餐确认失败", e);
			 return Msg.fail("午餐/晚餐确认失败");
		}
        return Msg.success().add("data",order);
    }
	
	@ApiOperation(value="酒水分类确认下单,",response=OrderDetail.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/drinks/confirm",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg createOrderDrinks(@RequestBody @Validated List<OrderDetail> orderDetail){
		try {
		    orderService.createOrderDrinks(orderDetail);
		}catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		}catch (Exception e) {
			logger.error("酒水分类确认下单失败", e);
			return Msg.fail("酒水分类确认下单失败");
		}
        return Msg.success();
    }
	
	@ApiOperation(value="每轮点餐确认下单,",response=OrderRound.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/round/confirm",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg createOrderRound(@RequestBody @Validated OrderRound orderRound){
		try {
		    orderService.createOrderRound(orderRound);
		}catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		}catch (Exception e) {
			logger.error("每轮点餐确认下单失败", e);
			return Msg.fail("每轮点餐确认下单失败");
		}
        return Msg.success();
    }
	
	@ApiOperation(value="点需要服务接口",response=OrderRound.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/needService",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg needService(@RequestBody @Validated OrderPrinterLog printerLog){
		try {
		    orderService.needService(printerLog);
		}catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		}catch (Exception e) {
			logger.error("需要服务接口失败", e);
			return Msg.fail("失败");
		}
        return Msg.success();
    }
	
	
	
	

}
