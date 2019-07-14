/**
 * FileName: CategoryService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:05
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Category;

import java.util.List;
import java.util.Map;

public interface CategoryService {

    List<Category> query(Category category);

    boolean addCategory(Category category);

    boolean editCategory(Category category);

    boolean reomveCategory(Integer id);

    boolean deleteByIds(List<Integer> ids);

    List<Category> getHaveProductCategories(Map<String, Object> map);

	Category getById(Integer id);
}
