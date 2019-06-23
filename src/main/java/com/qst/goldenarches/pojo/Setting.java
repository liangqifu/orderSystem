package com.qst.goldenarches.pojo;

import java.io.Serializable;

public class Setting implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * app开机密码
     */
    private String appPwd;

    /**
     * 每轮午餐能点的数量
     */
    private Integer lunchNum;

    /**
     * 每轮晚餐能点的数量
     */
    private Integer dinnerNum;

    /**
     * 每轮需要等的时间
     */
    private Integer waitTime;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAppPwd() {
        return appPwd;
    }

    public void setAppPwd(String appPwd) {
        this.appPwd = appPwd == null ? null : appPwd.trim();
    }

    public Integer getLunchNum() {
        return lunchNum;
    }

    public void setLunchNum(Integer lunchNum) {
        this.lunchNum = lunchNum;
    }

    public Integer getDinnerNum() {
        return dinnerNum;
    }

    public void setDinnerNum(Integer dinnerNum) {
        this.dinnerNum = dinnerNum;
    }

    public Integer getWaitTime() {
        return waitTime;
    }

    public void setWaitTime(Integer waitTime) {
        this.waitTime = waitTime;
    }
}