/**
 * FileName: AdminController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 17:59
 * Description: 管理员控制类
 */
package com.qst.goldenarches.controller;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Admin;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Permission;
import com.qst.goldenarches.pojo.Role;
import com.qst.goldenarches.service.AdminService;
import com.qst.goldenarches.service.CategoryService;
import com.qst.goldenarches.service.PermissionService;
import com.qst.goldenarches.service.RoleService;

import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@Controller
@RequestMapping("admin")
public class AdminController {
	private static Logger logger = LogManager.getLogger(AdminController.class);
    @Autowired
    private AdminService adminService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;
    @Autowired
    private CategoryService categoryService;


	@ResponseBody
    @RequestMapping(value= "/{id}/info",method=RequestMethod.GET,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg getAdminInfo(@PathVariable("id") Integer id){
		try {
			Admin admin = adminService.getAdminById(id);
			return Msg.success().add("data", admin);
		} catch (Exception e) {
			logger.error("获取管理信息失败", e);
			return Msg.fail("获取管理信息失败");
		}
    }
    /**
     * 跳转到错误页面(权限不足)
     * @return
     */
    @RequestMapping("error")
    public String error() {
        return "admin/error";
    }

    /**
     * 删除管理员的角色
     * @param adminId
     * @param assignRoleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("doUnAssign")
    public Object dounAssign( Integer adminId, Integer[] assignRoleIds ) {
        try {
            // 删除关系表数据
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("adminId", adminId);
            map.put("roleIds", assignRoleIds);
            adminService.removeAdminRoles(map);
            return Msg.success();
        } catch ( Exception e ) {
            e.printStackTrace();
            return Msg.fail();
        }
    }
    /**
     * 为管理员分配角色
     * @param adminId
     * @param unassignRoleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("doAssign")
    public Object doAssign( Integer adminId, Integer[] unassignRoleIds ) {
        try {
            // 增加admin_role关系表数据
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("adminId", adminId);
            map.put("roleIds", unassignRoleIds);
            adminService.addAdminRoles(map);
            return Msg.success();
        } catch ( Exception e ) {
            return Msg.fail();
        }
    }
    /**
     * 页面跳转：
     * 跳转到管理员角色分配页面
     * 数据回显，显示已经分配的角色
     * 和没有分配的角色
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/assign")
    public String assign( Integer id, Model model ) {

        Admin admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);

        List<Role> roles = roleService.getAllRoles(null);

        List<Role> assingedRoles = new ArrayList<Role>();
        List<Role> unassignRoles = new ArrayList<Role>();

        // 获取关系表的数据
        List<Integer> roleids = adminService.getRoleIdsByAdminId(id);
        for ( Role role : roles ) {
            if ( roleids.contains(role.getId()) ) {
                assingedRoles.add(role);
            } else {
                unassignRoles.add(role);
            }
        }
        model.addAttribute("assingedRoles", assingedRoles);
        model.addAttribute("unassignRoles", unassignRoles);
        return "admin/assign";
    }
    /**
     * 根据id删除管理员
     * @param adminid
     * @return
     */
    
    @ResponseBody
    @RequestMapping(value = "deleteBatch",method=RequestMethod.POST,
    	    consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg deleteBatch(@RequestBody List<Integer> ids) {
        try {
        	if(!CollectionUtils.isEmpty(ids)) {
        		adminService.removeAdmins(ids);
        	}
        } catch (Exception e) {
           logger.error("根据id删除管理员异常", e);
           return Msg.fail();
        }
        return Msg.success();
    }
    
   
    /**
     * 实现用户修改业务逻辑
     * @param admin
     * @return
     */
    @ResponseBody
    @RequestMapping(value= "update",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg update(@RequestBody Admin admin, HttpSession session) {
        try {
            Admin sessionAdmin =(Admin) session.getAttribute("loginAdmin");
            if(sessionAdmin.getId()==admin.getId()){
                adminService.editAdmin(admin);
                session.setAttribute("loginAdmin",admin);
                return Msg.success();
            }
            return Msg.fail();
        } catch ( Exception e ) {
            return Msg.fail();
        }
    }

    /**
     * 跳转到修改个人信息(admin)界面
     * @param model
     * @return
     */
    @RequestMapping("/edit")
    public String edit(HttpSession session,Model model ) {
        Admin admin =(Admin) session.getAttribute("loginAdmin");
        model.addAttribute("admin",admin);
        return "admin/edit";
    }

    /**
     * 新增界面实现新增业务
     * @param admin
     * @return
     */
    @ResponseBody
    @RequestMapping("doAdd")
    public Msg doAdd( Admin admin ) {
        try {
            if (adminService.validateAccountUnique(admin.getAccount())){
                admin.setPassword("1234");//默认密码
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                admin.setCreateTime(sdf.format(new Date()));
                adminService.addAdmin(admin);
                return Msg.success();
            }
            return Msg.fail();
        } catch ( Exception e ) {
             return Msg.fail();
        }

    }

    /**
     * 检验用户账户唯一性
     * @param account
     * @return
     */
    @RequestMapping("uniqueAcct")
    @ResponseBody
    public Msg validateAccountUnique(String account,HttpSession session){
        try {
            if(account!=null) {
                boolean flag = adminService.validateAccountUnique(account);
                if (flag){
                    return Msg.success();
                }
            }
            return Msg.fail().add("va_msg","账户已存在");
        }catch (Exception e){
            return Msg.fail().add("va_mag","服务异常,稍后重试");
        }
    }
    /**
     * 跳转到新增界面
     * @return
     */
    @RequestMapping("add")
    public String toAdd(){
        return "admin/add";
    }

    @ResponseBody
    @RequestMapping(value= "/queryListByPage",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg queryListByPage(@RequestBody Admin admin){
		try {
			PageHelper.startPage(admin.getPageNum(),admin.getPageSize());
			List<Admin> admins = adminService.query(admin);
			List<Role> roles = roleService.getAllRoles(null);
			for (Admin ad : admins) {
				// 获取关系表的数据
		        List<Integer> roleids = adminService.getRoleIdsByAdminId(ad.getId());
		        StringBuffer sb =  new StringBuffer();
		        for ( Role role : roles ) {
		            if (roleids.contains(role.getId()) ) {
		            	sb.append(role.getName()).append(",");
		            } 
		        }
		        if(sb.length()>0) {
		        	sb.deleteCharAt(sb.lastIndexOf(","));
		        	ad.setRolesName(sb.toString());
		        }
			}
	        com.github.pagehelper.PageInfo<Admin> adminPageInfo = new com.github.pagehelper.PageInfo<Admin>(admins,admin.getPageSize());
			return Msg.success().add("data",adminPageInfo);
		} catch (Exception e) {
			logger.error("分页查询列表异常",e);
			return Msg.fail(e.getMessage());
		}
    }
    
    
    /**
     * 页面跳转
     * 管理员列表主界面
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "admin/index";
    }

    /***
     * 管理员退出
     * @param session
     * @return
     */
    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/admin/login";
    }
    /**
     * 跳转到登陆后的主页面，
     * 也是数据分析主页面
     * @return
     */
    @RequestMapping("main")
    public String toMain(){
        return "admin/main";
    }
    @RequestMapping("dataAnalysis")
    public String toDataAnalysis(Model model ){
    	List<Category> categoryList = new ArrayList<Category>();
    	categoryList.add(categoryService.getById(1));
    	categoryList.add(categoryService.getById(2));
    	categoryList.add(categoryService.getById(3));
    	model.addAttribute("categoryList", categoryList);
        return "admin/dataAnalysis";
    }
    
    
    /**
     * 执行管理员登陆
     * @param admin
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/doLogin",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doLogin(@RequestBody Admin admin, HttpSession session){

        Admin dbAdmin =adminService.login(admin);
        if (dbAdmin!=null){
            session.setAttribute("loginAdmin",dbAdmin);

            // 获取用户权限信息
            List<Permission> permissions = permissionService.getPermissionsByAdmin(dbAdmin);
            Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
            Permission root = null;
            Set<String> uriSet = new HashSet<String>();
            for ( Permission permission : permissions ) {
                permissionMap.put(permission.getId(), permission);
                if ( permission.getUrl() != null && !"".equals(permission.getUrl()) ) {
                    uriSet.add(session.getServletContext().getContextPath() + permission.getUrl());
                }
            }
            session.setAttribute("authUriSet", uriSet);
            for ( Permission permission : permissions ) {
                Permission child = permission;
                if ( child.getPid() == 0 ) {
                    root = permission;
                } else {
                    Permission parent = permissionMap.get(child.getPid());
                    parent.getChildren().add(child);
                }
            }
            session.setAttribute("rootPermission", root);
            return Msg.success();
        }else {
            return Msg.fail();
        }
    }
    
    @ResponseBody
    @RequestMapping(value="/checkPwd",method=RequestMethod.POST,
            consumes=MediaType.APPLICATION_JSON_UTF8_VALUE,
    	    produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Msg doLogin(@RequestBody Map<String, String> params, HttpSession session){
    	String pwd = params.get("pwd");
        Admin loginAdmin = (Admin)session.getAttribute("loginAdmin");
        if (loginAdmin !=null){
        	Admin adminDb =  adminService.getAdminById(loginAdmin.getId());
        	if(!adminDb.getPassword().equals(pwd)) {
        		return Msg.fail(104,"密码错误");
        	}
            return Msg.success();
        }else {
            return Msg.fail(105,"请重新登录");
        }
    }
    /**
     * 跳转到登陆页面
     * @return
     */
    @RequestMapping("login")
    public String toLogin(){
        return "admin/login";
    }
}
