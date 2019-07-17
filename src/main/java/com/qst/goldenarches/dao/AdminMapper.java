/**
 * FileName: AdminMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 18:03
 * Description:管理员数据访问层
 */
package com.qst.goldenarches.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.qst.goldenarches.pojo.Admin;

public interface AdminMapper {
    /**
     * 根据传入的admin查询admin
     * @param admin
     * @return
     */
    @Select("SELECT * FROM t_admin WHERE account=#{account} AND password =#{password}")
    Admin selectAdminByAdmin(Admin admin);


    /**
     * 根据账号查询admin
     * @param account 账号
     * @return
     */
    @Select("SELECT * FROM t_admin WHERE account=#{account}")
    Admin selectAdminByAccount(String account);

    /**
     * 插入管理员数据
     * @param admin
     */
    @Insert("INSERT INTO t_admin VALUES(DEFAULT,#{name},#{account},#{password},#{createTime})")
    void insertAdmin(Admin admin);

    /**
     * 根据id 删除
     * @param map
     */
    void deleteAdmins(List<Integer> ids);

    /**
     * 根据id查询Admin
     * @param id admin id
     * @return
     */
    @Select("SELECT * FROM t_admin WHERE id=#{0}")
    Admin selectAdminById(Integer id);

    /**
     * 查询角色id
     * @param id 管理员id
     * @return
     */
    @Select("SELECT role_id FROM t_admin_role WHERE admin_id = #{0}")
    List<Integer> selectRoleIdsByAdminId(Integer id);

    /**
     * 插入管理员角色，在admin-role
     * @param map
     */
    void insertAdminRoles(Map<String, Object> map);

    /**
     * 删除管理员的角色
     * @param map
     */
    void deleteAdminRoles(Map<String, Object> map);

    /**
     * 更新管理员信息
     * @param admin
     */
    void updateAdmin(Admin admin);

	List<Admin> query(Admin admin);
}
