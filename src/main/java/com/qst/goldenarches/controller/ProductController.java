/**
 * FileName: ProductController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 20:45
 * Description:
 */
package com.qst.goldenarches.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
    @RequestMapping("deleteBatch")
    public Msg deleteBatch(Integer[] productid) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("productids", productid);
            productService.deleteProducts(map);
        } catch (Exception e) {
            e.printStackTrace();
           return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品后台：单个商品删除
     * @return
     */
    @ResponseBody
    @RequestMapping("deleteOne")
    public Msg deleteOne(Integer id, HttpServletRequest request){
        try {
            Product product =productService.getProductById(id);
            ImageUtil.dropPic(request,"product",product.getPic());
            productService.removeProduct(id);
        }catch (Exception e){
            return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品后台：商品图片修改
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="doUpdateProductPic",method=RequestMethod.POST,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doUpdateProductPic(HttpServletRequest request){
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile mFile = multipartRequest.getFile("pic");
        String img = ImageUtil.upload(request,"product",mFile);
        if (!StringUtils.isEmpty(img)){
            Product product =  productService.getProductById(Integer.parseInt(request.getParameter("id")));
            if(product !=null) {
            	String imgName=product.getPic();
                if (!StringUtils.isEmpty(imgName)){
                    ImageUtil.dropPic(request,"product",imgName);
                }
                try {
                	product.setPic(img);
                    boolean flag=productService.editProductPic(product);
                    if(flag){
                        return Msg.success();
                    }
                }catch (Exception e){
                	ImageUtil.dropPic(request,"product",img);
                    return  Msg.fail();
                }
            }
            
        }
        return Msg.fail();
    }
    /**
     * 商品后台：商品数据修改
     * @param product
     * @return
     */
    @ResponseBody
    @RequestMapping("doUpdateProductData")
    public Msg doUpdateProductData(Product product){
        boolean flag =productService.editProductData(product);
        if (flag){
            return Msg.success();
        }
        return Msg.fail();
    }
    /**
     * 商品后台：跳转方法
     * 跳转至商品商品修改界面,并回显
     * @return 页面地址 product/add
     */
    @RequestMapping("edit")
    public String goEdit(Integer id, Model model){
        Product product =productService.getProductById(id);
        //将原节点数据传递
        model.addAttribute("product", product);
        return "product/edit";
    }
    /**
     * 商品后台：商品添加方法
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "doAdd", method = RequestMethod.POST,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doAdd(HttpServletRequest request){
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile mFile = multipartRequest.getFile("pic");
        Product product =new Product();
        product.setName(request.getParameter("name"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setInventory(Integer.parseInt(request.getParameter("inventory")));
        product.setStatus(Integer.parseInt(request.getParameter("status")));
        product.setCid(Integer.parseInt(request.getParameter("cid")));
        if (!StringUtils.isEmpty(mFile.getOriginalFilename())){
            String img = ImageUtil.upload(request,"product",mFile);
            if (!StringUtils.isEmpty(img)) {
                product.setPic(img);
            }
        }
        try {
            boolean flag =productService.addProduct(product);
            if (flag){
                return Msg.success();
            }else return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail().add("msg","服务器异常");
        }
    }
    /**
     * 商品后台：跳转方法
     * 跳转至商品商品添加
     * @return 页面地址 product/add
     */
    @RequestMapping("/add")
    public String add(){
        return "product/add";
    }
    /**
     * 商品后台：分页查找
     * 查询全部商品并分页显示
     * @param pn 页码
     * @return json数据 Msg
     */
    @ResponseBody
    @RequestMapping("/getAll")
    public Msg getAll(@RequestParam(value = "pageno",defaultValue = "1") Integer pn,String queryText){
        PageHelper.startPage(pn,10);
        List<Product> products =productService.getAll(queryText);
        com.github.pagehelper.PageInfo<Product> productPageInfo =new com.github.pagehelper.PageInfo<Product>(products,5);
        return Msg.success().add("pageInfo",productPageInfo);
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
