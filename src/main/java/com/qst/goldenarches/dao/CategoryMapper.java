/**
 * FileName: CategoryMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:07
 * Description:
 */
package com.qst.goldenarches.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qst.goldenarches.pojo.Category;

public interface CategoryMapper {

    List<Category> query(Category category);

    int insertCategory(Category category);

    int updateCategory(Category category);

    int deleteCategory(Integer id);

    int deleteByIds(List<Integer> ids);

    List<Category> selectHaveProductCategories(Map<String, Object> map);

	Category getById(Integer id);
	
	Category queryPrinterByCategoryId(@Param("categoryId")Integer categoryId);
}
