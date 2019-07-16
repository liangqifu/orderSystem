/**
 * FileName: ServerStartupListener
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:20
 * Description:用于处理资源路径问题
 */
package com.qst.goldenarches.web;


import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.qst.goldenarches.pojo.Permission;
import com.qst.goldenarches.service.PermissionService;


public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static Logger logger = LogManager.getLogger(AuthInterceptor.class);
	@Autowired
	private PermissionService permissionService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 获取用户的请求地址
		String uri = request.getRequestURI();
		String path = request.getSession().getServletContext().getContextPath();
		// 查询所有需要验证的路径集合
		Set<String> uriSet = new HashSet<String>();
		try {
			List<Permission> permissions = permissionService.getAllPermissions();
			for ( Permission permission : permissions ) {
				if ( permission.getUrl() != null && !"".equals(permission.getUrl()) ) {
					uriSet.add(path + permission.getUrl());
				}
			}
		} catch (Exception e) {
			logger.error("preHandle 异常",e);
			String context = path + "/admin/login";
			response.getWriter().write("<script>window.top.location.href=\""+context+"\";</script>");
			return false;
		}
		if (uriSet.contains(uri) ) {
			// 权限验证
			// 判断当前用户是否拥有对应的权限
			Set<String> authUriSet = (Set<String>)request.getSession().getAttribute("authUriSet");
			if(authUriSet == null) {
				String context = path + "/admin/login";
				response.getWriter().write("<script>window.top.location.href=\""+context+"\";</script>");
				return false;
			}
			if (authUriSet.contains(uri) ) {
				return true;
			} else {
				String context = path + "/admin/error";
				response.getWriter().write("<script>window.top.location.href=\""+context+"\";</script>");
				return false;
			}
		} else {
			return true;
		}
	}

}
