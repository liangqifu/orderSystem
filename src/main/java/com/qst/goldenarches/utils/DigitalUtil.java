/**
 * FileName: DigitalUtil
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 21:15
 * Description: 数字转换工具类
 */
package com.qst.goldenarches.utils;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class DigitalUtil {
	
	public static boolean isHostReachable(String host, Integer timeOut) {
        try {
            return InetAddress.getByName(host).isReachable(timeOut);
        } catch (UnknownHostException e) {
        	return false;
        } catch (IOException e) {
        	return false;
        }
    }

    /**
     * 将数字向上转换成
     * 最低以十为单位
     * 最高以万为单位
     * @param num
     * @return
     */
    public static Integer convertLeastTenAsUnit( int num){
        if(num<0||num>999999999){//当数字超出范围
            return -1;
        }
        int numOfDigits=0;//数字的位数
        int numTmp =num;
        if (numTmp==0){
            numOfDigits=1;
        }else {
            while (numTmp>0){
                numTmp =numTmp/10;
                numOfDigits++;
            }
        }
        int unit =10;//最低单位
        if(numOfDigits>5){//限制最高以万为单位
            numOfDigits=6;
        }
        if (numOfDigits>2){
            unit =(int)Math.pow(10, numOfDigits-2);
        }
        num =((num/unit)+1)*unit;
        return num;
    }
    public static Integer convertLeastTenAsUnit( double num){
        int n =(int) num;
        return convertLeastTenAsUnit(n);
    }
    
    /**
           * 提供精确加法计算的add方法
     * @param value1 被加数
     * @param value2 加数
     * @return 两个参数的和
     */
    public static double add(double value1,double value2){
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.add(b2).doubleValue();
    }

    /**
         * 提供精确减法运算的sub方法
     * @param value1 被减数
     * @param value2 减数
     * @return 两个参数的差
     */
    public static double sub(double value1,double value2){
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.subtract(b2).doubleValue();
    }

    /**
        * 提供精确乘法运算的mul方法
     * @param value1 被乘数
     * @param value2 乘数
     * @return 两个参数的积
     */
    public static double mul(double value1,double value2){
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.multiply(b2).doubleValue();
    }

    /**
         * 提供精确的除法运算方法div
     * @param value1 被除数
     * @param value2 除数
     * @param scale 精确范围
     * @return 两个参数的商
     * @throws IllegalAccessException
     */
    public static double div(double value1,double value2,int scale) throws IllegalAccessException{
        //如果精确范围小于0，抛出异常信息
        if(scale<0){         
            throw new IllegalAccessException("精确度不能小于0");
        }
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.divide(b2, scale).doubleValue();    
    }

}
