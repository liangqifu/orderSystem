/**
 * FileName: ProductMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 21:30
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Product;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface ProductMapper {


    List<Product> selectAll(@Param("text") String text);

    int insertProduct(Product product);

    Product selectProductById(@Param("id")Integer id);

    int updateBySelective(Product product);

    @Delete("DELETE FROM product_info WHERE product_id =#{0}")
    void deleteProductById(Integer id);

    void deleteProducts(List<Integer> ids);

    @Select("SELECT COUNT(*) FROM product_info WHERE category_id =#{cid}")
    int countProductByCid(Integer id);

    public List<Product> selByPage(Map<String, Integer> map);

    public int selCount(@Param("categoryId") Integer categoryId);

    @Select("select category_id id,category_name name from product_category where category_id=#{0}")
    public Category selById(int id);

    @Select("select category_id id,category_name name from product_category")
    public List<Category> selAllCategory();

	List<Product> query(Product product);

	int checkNo(Product product);

}
