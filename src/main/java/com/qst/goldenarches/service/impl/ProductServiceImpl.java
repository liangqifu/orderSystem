/**
 * FileName: ProductServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 21:29
 * Description:
 */
package com.qst.goldenarches.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.dao.ProductMapper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.PageInfo;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    public List<Product> getAll(String text) {
        return productMapper.selectAll(text);
    }

	@Override
	public List<Product> query(Product product) {
		return productMapper.query(product);
	}

    public boolean addProduct(Product product) {
        return productMapper.insertProduct(product)==1?true:false;
    }

    public Product getProductById(Integer id) {
        return productMapper.selectProductById(id);
    }

    public void removeProduct(Integer id) {
        productMapper.deleteProductById(id);
    }

    public void deleteProducts(List<Integer> ids) {
        productMapper.deleteProducts(ids);
    }

    public boolean isTypeHaveProduct(Integer id) {
        int count =productMapper.countProductByCid(id);
        return count==0?false:true;
    }

    public PageInfo showPage(String pageNumStr, Integer categoryId) {
        //每页多少个
        int pageSize = 6;
        //当前是第几页
        int pageNum = 1;
        //如果没传入值就用上边定义的默认的第一页，如果传入值则获取值并转换成int格式
        if(pageNumStr != null && !pageNumStr.equals("")){
            pageNum = Integer.parseInt(pageNumStr);
        }
        //如果类型为空，则获取数据库中的第一列的数据
//        if(category == null || category.equals("")){
//            category = productMapper.selAllCategory().get(0).getName();
//        }
        //当前类型共有多少商品
        int count = productMapper.selCount(categoryId);
        //当前页从第几个商品开始
        int pageStart = (pageNum - 1) * pageSize;
        //总共多少页
        int total = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;


        PageInfo pageInfo = new PageInfo();
        pageInfo.setPageNum(pageNum);
        pageInfo.setPageSize(pageSize);
        pageInfo.setTotal(total);
        pageInfo.setPageStart(pageStart);
        //pageInfo.setCategory(categoryId);
        Map<String,Integer> map =new HashMap<String, Integer>();
        map.put("categoryId",categoryId);
        //当前页商品集合
        PageHelper.startPage(pageNum,6);
        List<Product> list = productMapper.selByPage(map);
        pageInfo.setList(list);
        return pageInfo;
    }

    public List<Category> getCategory(){
        return productMapper.selAllCategory();
    }

	@Override
	public int update(Product product) {
		return productMapper.updateBySelective(product);
	}

	@Override
	public boolean checkNo(Product product) {
		int count = productMapper.checkNo(product);
		return count>0;
	}

}
