package com.qst.goldenarches.pojo;

import java.io.Serializable;

public class Area implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * ²ÍÇøÃû³Æ
     */
    private String name;

    /**
     * ²ÍÇøÃÜÂë
     */
    private String pwd;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }
}