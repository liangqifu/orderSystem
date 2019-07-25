package com.qst.goldenarches.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.exception.BusException;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.OrderRound;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.AreaService;
import com.qst.goldenarches.service.CategoryService;
import com.qst.goldenarches.service.OrderService;
import com.qst.goldenarches.service.ProductService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.vo.OrderDetailVo;
import com.qst.goldenarches.vo.OrderNeedServiceVo;
import com.qst.goldenarches.vo.OrderUpdateVo;
import com.qst.goldenarches.vo.SignInVo;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api(value="app接口",description="App接口文档")
@Controller
@RequestMapping("/app")
public class AppController {
	private static Logger logger = LogManager.getLogger(AppController.class);
	
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
		try {
			Setting setting = settingService.getSettingInfo();
			if(setting == null) {
				return Msg.fail("系统未授权App登录");
			}
			if("1".equals(vo.getType())) {
				if(!vo.getPwd().equals(setting.getAppPwd())) {
					return Msg.fail("登录密码不正确");
				}
			} else {
				if(!vo.getPwd().equals(setting.getCtlAppPwd())) {
					return Msg.fail("登录密码不正确");
				}
			}
			Area area = new Area();
			area.setState("0");
			return Msg.success().add("setting",setting).add("areas", areaService.query(area));
		} catch (Exception e) {
			logger.error("App登录异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	
	
	@ApiOperation(value="根据父级分类id获取子分类",response=Setting.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "getCategorysByPid",method=RequestMethod.GET,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryListByPage(@RequestParam Integer parentId,HttpServletRequest request){
		Category param = new Category();
		param.setParentId(parentId);
		param.setState("0");
        List<Category> categories = categoryService.query(param);
        String imgPath = request.getServletContext().getContextPath()+"/img/category/";
        return Msg.success().add("data",categories).add("imgPath", imgPath);
    }
	
	@ApiOperation(value="分页查询菜品列表",response=Product.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/product/queryListByPage",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryProductListByPage(@RequestBody @Validated Product product,HttpServletRequest request){
		try {
			PageHelper.startPage(product.getPageNum(),product.getPageSize());
			product.setStatus("1");
			List<Product> list = productService.query(product);
			com.github.pagehelper.PageInfo<Product> pageInfo = new com.github.pagehelper.PageInfo<Product>(list,product.getPageSize());
			String imgPath = request.getServletContext().getContextPath()+"/img/product/";
			return Msg.success().add("data",pageInfo).add("imgPath", imgPath);
		} catch (Exception e) {
			logger.error("分页查询菜品列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	@ApiOperation(value="午餐/晚餐确认,",notes="PS:如果后台返回状态码code为101，则表示台号已被占用,100=成功，200=失败",response=OrderMaster.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/confirm",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg createOrderMaster(@RequestBody @Validated OrderMaster order){
		try {
			order = orderService.createOrderMaster(order);
		} catch (BusException e) {
			logger.error(e.getErrorMsg(), e);
			return Msg.fail(e.getErrorCode(),e.getErrorMsg());
		} catch (Exception e) {
			logger.error("午餐/晚餐确认失败", e);
			return Msg.fail("午餐/晚餐确认失败");
		}
        return Msg.success().add("data",order);
    }
	
	@ApiOperation(value="更新订单设置信息",notes="PS:如果后台返回状态码code为101，则表示台号已被占用,100=成功，200=失败",response=Msg.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/update",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg updateOrderMaster(@RequestBody @Validated OrderUpdateVo updateVo){
		try {
			OrderMaster order= new OrderMaster(); 
			BeanUtils.copyProperties(updateVo, order);
			orderService.updateOrderMaster(order);
		} catch (BusException e) {
			logger.error(e.getErrorMsg(), e);
			return Msg.fail(e.getErrorCode(),e.getErrorMsg());
		} catch (Exception e) {
			logger.error("更新订单设置信息失败", e);
			 return Msg.fail("更新订单设置信息失败");
		}
        return Msg.success();
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
	
	@ApiOperation(value="服务类确认接口",response=OrderRound.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/needService/confirm",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg needService(@RequestBody @Validated OrderNeedServiceVo needServiceVo){
		try {
		    orderService.needService(needServiceVo);
		}catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		}catch (Exception e) {
			logger.error("需要服务接口失败", e);
			return Msg.fail("失败");
		}
        return Msg.success();
    }
	
	@ApiOperation(value="通知付款",notes="PS:如果后台返回状态码code为102，则表示该订单已通知付款,提示不要重复点击,100=成功，200=失败",response=Msg.class,produces="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/notifyPay",method=RequestMethod.POST,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg notifyPay(@RequestParam Integer orderId){
		try {
		    orderService.notifyPay(orderId);
		}catch (BusException e) {
			logger.error(e.getErrorMsg(), e);
			return Msg.fail(102,e.getErrorMsg());
		}catch (Exception e) {
			logger.error("通知付款失败", e);
			return Msg.fail("通知付款失败");
		}
        return Msg.success();
    }
	
	@ApiOperation(value="根据orderId/roundId分页查询订单详情列表",notes="注意：参数orderId必填,参数roundId选填",response=OrderDetail.class,produces="application/json;charset=UTF-8",consumes="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/queryOrderDetail",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryOrderDetail(@RequestBody @Validated OrderDetailVo param){
		try {
			PageHelper.startPage(param.getPageNum(),param.getPageSize());
			param.setState("0");
			OrderDetail orderDetail= new OrderDetail(); 
			BeanUtils.copyProperties(param, orderDetail);
			List<OrderDetail> list = orderService.queryOrderDetail(orderDetail);
	        com.github.pagehelper.PageInfo<OrderDetail> pageInfo = new com.github.pagehelper.PageInfo<OrderDetail>(list,param.getPageSize());
			return Msg.success().add("data", pageInfo);
		} catch (Exception e) {
			logger.error("获取订单详情失败", e);
			return Msg.fail("获取订单详情失败");
		}
    }
	
	@ApiOperation(value="根据orderId获取订单详情",response=OrderMaster.class,produces="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/order/{orderId}/info",method=RequestMethod.GET,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg getOrderInfoByOrderId(@PathVariable("orderId") Integer orderId){
		try {
			OrderMaster order = orderService.getOrderInfoByOrderId(orderId);
			return Msg.success().add("data", order);
		} catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		}catch (Exception e) {
			logger.error("获取订单详情失败", e);
			return Msg.fail("获取订单详情失败");
		}
    }
	
	
	@ApiOperation(value="控制面板--获取餐区信息，每个餐区包含多个订单",response=Area.class,produces="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/ctl/getAreaList",method=RequestMethod.GET,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg getAreaList(){
		try {
			Area param = new Area();
			param.setState("0");
			List<Area> areaList = areaService.query(param);
			for (Area area : areaList) {
				OrderMaster queryParam = new OrderMaster();
				queryParam.setBuyerId(area.getId());
				queryParam.setStatusStr("0,1");
				queryParam.setState("0");
				List<OrderMaster> orders = orderService.queryOrderList(queryParam);
				area.setOrders(orders);
			}
			return Msg.success().add("data", areaList);
		} catch (Exception e) {
			logger.error("获取餐区信息失败", e);
			return Msg.fail("获取餐区信息失败");
		}
    }
	
	
	@ApiOperation(value="控制面板--订单确认结账",response=Msg.class,produces="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/ctl/order/settlement",method=RequestMethod.POST,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg orderSettlement(@RequestParam Integer orderId){
		try {
			orderService.orderSettlement(orderId);
			return Msg.success();
		} catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		} catch (Exception e) {
			logger.error("控制面板--订单确认结账失败", e);
			return Msg.fail("控制面板--订单确认结账失败");
		}
    }
	
	@ApiOperation(value="控制面板--订单取消",response=Msg.class,produces="application/json;charset=UTF-8")
	@ResponseBody
    @RequestMapping(value= "/ctl/order/cancel",method=RequestMethod.POST,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg orderCancel(@RequestParam Integer orderId){
		try {
			orderService.orderCancel(orderId);
			return Msg.success();
		} catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		} catch (Exception e) {
			logger.error("控制面板--订单确认取消失败", e);
			return Msg.fail("控制面板--订单确认取消失败");
		}
    }
	

}
