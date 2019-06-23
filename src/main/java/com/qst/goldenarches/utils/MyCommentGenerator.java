package com.qst.goldenarches.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.InnerClass;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.xml.XmlElement;
import org.mybatis.generator.internal.DefaultCommentGenerator;
public class MyCommentGenerator extends DefaultCommentGenerator {
	private Properties properties;
    private Properties systemPro;
    private boolean suppressDate;
    private boolean suppressAllComments;
    private String currentDateStr;
 
    public MyCommentGenerator() {
        super();
        this.properties = new Properties();
        this.systemPro = System.getProperties();
        this.suppressDate = false;
        this.suppressAllComments = false;
        this.currentDateStr = (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
    }
 
 
    public void addFieldComment(Field field, IntrospectedTable introspectedTable,
                                IntrospectedColumn introspectedColumn) {
        StringBuilder sb = new StringBuilder();
        field.addJavaDocLine("/**");
        sb.append(" * ");
        sb.append(introspectedColumn.getRemarks());
        field.addJavaDocLine(sb.toString().replace("\n", " "));
        field.addJavaDocLine(" */");
    }
    
    
    @Override
	public void addComment(XmlElement xmlElement) {
    	
	}


	public void addFieldComment(Field field, IntrospectedTable introspectedTable) {
 
    }
 
    public void addGeneralMethodComment(Method method, IntrospectedTable introspectedTable) {
 
    }
 
    public void addGetterComment(Method method, IntrospectedTable introspectedTable,
                                 IntrospectedColumn introspectedColumn) {
 
    }
 
    public void addSetterComment(Method method, IntrospectedTable introspectedTable,
                                 IntrospectedColumn introspectedColumn) {
 
    }
 
    public void addClassComment(InnerClass innerClass, IntrospectedTable introspectedTable, boolean markAsDoNotDelete) {
 
    }
 
    public void addClassComment(InnerClass innerClass, IntrospectedTable introspectedTable) {
    }

}
