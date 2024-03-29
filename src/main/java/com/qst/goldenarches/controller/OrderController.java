/**
 * FileName: OrderController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:17
 * Description: 后台：订单控制器
 */
package com.qst.goldenarches.controller;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.exception.BusException;
import com.qst.goldenarches.pojo.Area;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.OrderDetail;
import com.qst.goldenarches.pojo.OrderMaster;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.AreaService;
import com.qst.goldenarches.service.OrderService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.utils.ExcelUtil;
import com.qst.goldenarches.utils.ResourceUtils;
import com.qst.goldenarches.utils.ExcelUtil.ExportOrderInfo;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("order")
public class OrderController {
	private static Logger logger = LogManager.getLogger(OrderController.class);
    @Autowired
    private OrderService orderService;
    @Autowired
	private AreaService areaService;
    @Autowired
	private SettingService settingService;
    

    
	@ResponseBody
    @RequestMapping(value= "/queryOrderListByPage",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryOrderListByPage(@RequestBody OrderMaster queryParam){
		 try {
			 PageHelper.startPage(queryParam.getPageNum(),queryParam.getPageSize());
			 queryParam.setState("0");
			 List<OrderMaster> list = orderService.queryOrderList(queryParam);
			 com.github.pagehelper.PageInfo<OrderMaster> orders = new com.github.pagehelper.PageInfo<OrderMaster>(list,queryParam.getPageSize());
			 return Msg.success().add("data", orders);
		} catch (Exception e) {
			logger.error("查询订单列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	@RequestMapping(value= "/exportExcel",method=RequestMethod.POST)
	public void exportExcel(OrderMaster queryParam, HttpServletResponse response){
		 try {
			queryParam.setState("0");
			List<OrderMaster> list = orderService.queryOrderList(queryParam);
			OrderDetail param = new OrderDetail();
			for (OrderMaster orderMaster : list) {
				param.setOrderId(orderMaster.getOrderId());
				param.setState("0");
				param.setDetailType("1,2");
				orderMaster.setOrderDetails(orderService.queryOrderDetail(param));
			}
			response.reset(); //清除buffer缓存
			Setting setting  = settingService.getSettingInfo();
			 // 指定下载的文件名
			String filename = ResourceUtils.getValueByLanguage("excel-title", setting.getLanguage());
			filename = new String(filename.getBytes(), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls");
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
	
			 ExportOrderInfo setInfo =  new ExportOrderInfo();
			 setInfo.setOrderList(list);
			 setInfo.setSetting(setting);
			 setInfo.setOut(response.getOutputStream());
			 ExcelUtil.exportExcel(setInfo);
		} catch (Exception e) {
			logger.error("查询订单列表异常",e);
		}
   }
	
	
	@ResponseBody
    @RequestMapping(value= "/queryAreaList",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryAreaList(@RequestBody Area queryParam){
		 try {
			 List<Area> list = areaService.query(queryParam);
			 return Msg.success().add("data", list);
		} catch (Exception e) {
			logger.error("查询餐区列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	@ResponseBody
    @RequestMapping(value= "/delOrder",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg delOrder(@RequestBody Map<String, Object> param){
		try {
			 orderService.delOrder(param);
			 return Msg.success();
		} catch (BusException e) {
			logger.error(e.getMessage(), e);
			return Msg.fail(e.getMessage());
		} catch (Exception e) {
			logger.error("查询餐区列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	
	
	
    

    /***
     * 订单后台：跳转方法
     * 跳转到订单详情主页
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("index")
    public String index(HttpServletRequest request,Model model){
    	 Set<String> authUriSet = (Set<String>)request.getSession().getAttribute("authUriSet");
    	 model.addAttribute("orderDel", authUriSet.contains("orderDel"));
    	 return "order/index";
    }

}
