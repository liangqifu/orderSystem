/**
 * FileName: Msg
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/4/14 18:13
 * Description: 通用的返回类
 */
package com.qst.goldenarches.pojo;

import java.util.HashMap;
import java.util.Map;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
@ApiModel(value="返回JSON对象",description="返回JSON对象")
public class Msg {

    //状态码，
	@ApiModelProperty(value="状态码:100成功，其他未失败")
    private int code;
    //提示信息
	@ApiModelProperty(value="提示信息")
    private String msg;

    //用户要返回给浏览器的数据
	@ApiModelProperty(value="返回的数据")
    private Map<String,Object> extend =new HashMap<String, Object>();

    public static Msg success(){
        Msg result =new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result =new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    public static Msg fail(String msg){
        Msg result =new Msg();
        result.setCode(200);
        result.setMsg(msg);
        return result;
    }
    public static Msg fail(Integer code ,String msg){
        Msg result =new Msg();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }

    public Msg add(String key,Object value){
        this.extend.put(key,value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
