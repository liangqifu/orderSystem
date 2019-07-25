/**
 * FileName: ProductController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 20:45
 * Description:
 */
package com.qst.goldenarches.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.PageInfo;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.service.ProductService;
import com.qst.goldenarches.utils.ImageUtil;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("/product")
public class ProductController {
	private static Logger logger = LogManager.getLogger(ProductController.class);
    @Autowired
    private ProductService productService;

    /**
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("isProductExist")
    public Msg getProductById(Integer id){
        if(productService.isTypeHaveProduct(id)){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }
    /***
     * 商品后台：批量删除商品
     * @param productid
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteBatch",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg deleteBatch(@RequestBody List<Integer> ids) {
        try {
            productService.deleteProducts(ids);
        } catch (Exception e) {
           logger.error("批量删除商品异常", e);
           return Msg.fail();
        }
        return Msg.success();
    }
    
    @ResponseBody
    @RequestMapping(value= "save",method=RequestMethod.POST,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg save(Product product,HttpServletRequest request){
    	Product productDB = null;
    	if(product.getId()>0) {
    		productDB = productService.getProductById(product.getId());
    		if(!productDB.getNo().equals(product.getNo())) {
    			if(productService.checkNo(product)) {
    				return Msg.fail(103,"菜品编号重复，请重新输入");
    			}
    		}
    	}else {
    		if(productService.checkNo(product)) {
				return Msg.fail(103,"菜品编号重复，请重新输入");
			}
    	}
    	 MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
         MultipartFile mFile = multipartRequest.getFile("picture");
         if (!StringUtils.isEmpty(mFile.getOriginalFilename())){
             String img = ImageUtil.upload(request,"product",mFile);
             if (!StringUtils.isEmpty(img)) {
            	 product.setPic(img);
             }
         }
    	 try {
			if(productDB !=null ) {
				if(!StringUtils.isEmpty(product.getPic())) {
					productDB = productService.getProductById(product.getId());
					if(!StringUtils.isEmpty(productDB.getPic())) {
						ImageUtil.dropPic(request,"product",productDB.getPic());
					}
				}
				productService.update(product);
				return Msg.success();
			 }else {
				productService.addProduct(product);
				return Msg.success();
			 }
		} catch (Exception e) {
			logger.error("save product 异常",e);
			return Msg.fail(e.getMessage());
		}
    }
    
    
	@ResponseBody
    @RequestMapping(value= "/queryListByPage",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryProductListByPage(@RequestBody Product product,HttpServletRequest request){
		try {
			PageHelper.startPage(product.getPageNum(),product.getPageSize());
			List<Product> list = productService.query(product);
			com.github.pagehelper.PageInfo<Product> pageInfo = new com.github.pagehelper.PageInfo<Product>(list,product.getPageSize());
			String imgPath = request.getServletContext().getContextPath()+"/img/product/";
			return Msg.success().add("data",pageInfo).add("imgPath", imgPath);
		} catch (Exception e) {
			logger.error("分页查询菜品列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	@ResponseBody
    @RequestMapping(value= "/update",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg update(@RequestBody Product product,HttpServletRequest request){
		try {
			productService.update(product);
			return Msg.success();
		} catch (Exception e) {
			logger.error("更新菜品异常",e);
			return Msg.fail(e.getMessage());
		}
    }
	
	
    /**
     * 商品后台：跳转方法
     * 跳转至商品显示主界面
     * @return 页面地址 /product/index
     */
    @RequestMapping("/index")
    public String index(){
        return "product/index";
    }


    /**
     * 展示页面
     * 2018/10/18 修改 category ==>categoryId
     * @param pageNum
     * @param categoryId 类别id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/show")
    public String show(@RequestParam(value = "pageNum",defaultValue = "1")String pageNum, Integer categoryId,HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        PageInfo pageInfo = productService.showPage(pageNum,categoryId);
        /*PageHelper.startPage(Integer.parseInt(pageNum),6);
        List<Product> products =productService.getAll(null);
        pageInfo.setList(products);*/
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("category",productService.getCategory());
        request.setAttribute("hint","notFist");
        return "forward:/main.jsp";
    }

    /**
     * 刷新页面
     * 2018/10/18 修改 category ==>categoryId
     * @param pageNum
     * @param categoryId 类别id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/refresh")
    public String refresh(@RequestParam(value = "pageNum",defaultValue = "1")String pageNum,Integer categoryId,HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        PageInfo pageInfo = productService.showPage(pageNum,categoryId);
        /*PageHelper.startPage(Integer.parseInt(pageNum),6);
        List<Product> products =productService.getAll(null);
        pageInfo.setList(products);*/
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("category",productService.getCategory());
        return "forward:/shop.jsp";
    }
}
