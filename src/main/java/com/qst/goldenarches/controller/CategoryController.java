/**
 * FileName: CategoryController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:04
 * Description:
 */
package com.qst.goldenarches.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.TreeNode;
import com.qst.goldenarches.service.CategoryService;

import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /***
     * 商品类别：获取类别
     * 根据传入的商品类别id获取有商品的商品类别
     * @param categoryid
     * @return
     */
    @ResponseBody
    @RequestMapping("getCategories")
    public Msg getHaveProductCategories(Integer[] categoryid){
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("categoryids", categoryid);
        List<Category> categories =categoryService.getHaveProductCategories(map);
        return  Msg.success().add("categoryList",categories);
    }

    /***
     * 商品类别：批量删除商品类别
     * @param categoryid
     * @returns
     */
    @ResponseBody
    @RequestMapping(value = "deleteBatch",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg deleteBatch(@RequestBody Integer[] categoryid){
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("categoryids", categoryid);
            if (!categoryService.deleteProducts(map)){
                return Msg.fail();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success();
    }
    
    /**
     * 商品类别：执行商品信息修改方法
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("doEdit")
    public Msg doEdit(Category category){
        try {
            if(!categoryService.editCategory(category)){
                return Msg.fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success();
    }
    
    @ResponseBody
    @RequestMapping(value= "save",method=RequestMethod.POST,
    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg save(@RequestBody Category category){
    	if(category.getId()>0) {
    		return this.doEdit(category);
    	}else {
    		return this.doAdd(category);
    	}
    }
    
    /**
     * 商品类别：跳转方法
     * 跳转到商品类别修改界面
     * @return
     */
    @RequestMapping("edit")
    public String toEdit(Category category, Model model){
    	category = categoryService.getById(category.getId());
        model.addAttribute("category", category);
        return "category/edit";
    }
    
    
    @ResponseBody
    @RequestMapping(value= "{id}/info",method=RequestMethod.GET,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg getById(@PathVariable("id") Integer id){
        return Msg.success().add("data",categoryService.getById(id));
    }

    /**
     * 商品类别：添加商品类别
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("doAdd")
    public Msg doAdd(Category category){
        Boolean flag =categoryService.addCategory(category);
        if (flag){
            return Msg.success().add("category",category);
        }
        return Msg.fail();
    }
    /***
     * 商品类别：跳转方法
     * 跳转到商品类别添加界面
     * @return
     */
    @RequestMapping("add")
    public String toAdd(Category category, Model model){
    	model.addAttribute("category", category);
        return "category/add";
    }
    /**
     * 商品类别：分页查找
     * 查询全部商品类别并分页显示
     * @param pn 页码
     * @return json数据 Msg
     */
    @ResponseBody
    @RequestMapping(value= "queryListByPage",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryListByPage(@RequestBody Category category){
        PageHelper.startPage(category.getPageNum(),category.getPageSize());
        List<Category> categories =categoryService.query(category);
        com.github.pagehelper.PageInfo<Category> categoryPageInfo =new com.github.pagehelper.PageInfo<Category>(categories,category.getPageSize());
        return Msg.success().add("data",categoryPageInfo);
    }
    
    @ResponseBody
    @RequestMapping(value= "queryList",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryList(@RequestBody Category category){
	   List<Category> categories = categoryService.query(category);
	   return Msg.success().add("data",categories);
	}

    /**
     * 商品后台：跳转方法
     * 跳转至商品类别主页
     * @return
     */
    @RequestMapping("index")
    public String toIndex(){
        return "category/index";
    }
   
    
    
    @RequestMapping(value = "getTreeListAll",method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<TreeNode> getTreeListAll() throws Exception{
    	Category param = new Category();
    	param.setState("0");
		List<Category> categories = categoryService.query(param);
		List<TreeNode> treeNodes = new ArrayList<TreeNode>(categories.size());
		treeNodes.add(new TreeNode("0","", "ROOT", true, false, false));
		for (Category category : categories) {
			treeNodes.add(new TreeNode(category.getId()+"", category.getParentId()+"", category.getName(), true, false, false));
		}
		return treeNodes;
	}

}
