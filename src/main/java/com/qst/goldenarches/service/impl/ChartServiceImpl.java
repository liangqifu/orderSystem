/**
 * FileName: ChartServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 14:18
 * Description:
 */
package com.qst.goldenarches.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.qst.goldenarches.dao.OrderDetailMapper;
import com.qst.goldenarches.dao.OrderMasterMapper;
import com.qst.goldenarches.pojo.Setting;
import com.qst.goldenarches.service.ChartService;
import com.qst.goldenarches.service.SettingService;
import com.qst.goldenarches.utils.DigitalUtil;
import com.qst.goldenarches.utils.ResourceUtils;

@Service
public class ChartServiceImpl implements ChartService {

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Autowired
    private OrderMasterMapper orderMasterMapper;
    @Autowired
	private SettingService settingService;

    public List<Map<String,Object>> getEveryProTypeSaleNum(Map<String, Object> params) {
    	return orderDetailMapper.queryEveryProTypeSaleNum(params);
    }

    public Map<String, Object> getEveryMonthBarData(Map<String, Object> params) {
    	List<Integer> maxCount = new ArrayList<Integer>();//保存所有月份中最高销售数量
        List<Map<String,Object>> series =new ArrayList<Map<String,Object>>();
        List<String> itemList =new ArrayList<String>();
        List<Map<String, Object>> retSaleNumList =  orderDetailMapper.queryEveryMonthSaleNum(params);
        for (Map<String, Object> map : retSaleNumList) {
        	//用于保存该类别下的每个月份的销售情况
            List<Integer> dataList =new ArrayList<Integer>();
            dataList.add(Integer.valueOf(map.get("m1").toString()));
            dataList.add(Integer.valueOf(map.get("m2").toString()));
            dataList.add(Integer.valueOf(map.get("m3").toString()));
            dataList.add(Integer.valueOf(map.get("m4").toString()));
            dataList.add(Integer.valueOf(map.get("m5").toString()));
            dataList.add(Integer.valueOf(map.get("m6").toString()));
            dataList.add(Integer.valueOf(map.get("m7").toString()));
            dataList.add(Integer.valueOf(map.get("m8").toString()));
            dataList.add(Integer.valueOf(map.get("m9").toString()));
            dataList.add(Integer.valueOf(map.get("m10").toString()));
            dataList.add(Integer.valueOf(map.get("m11").toString()));
            dataList.add(Integer.valueOf(map.get("m12").toString()));
            maxCount.addAll(dataList);
        	String name = map.get("name").toString();
        	//将该类的数据封装成对象
            Map<String,Object> data =new HashMap<String, Object>();
            data.put("name",name);
            data.put("type","bar");//柱状图
            data.put("data",dataList);
            series.add(data);
            itemList.add(name);
            
		}
        
        Map<String, Object> retMap =  orderDetailMapper.queryEveryMonthMoney(params);
        
        List<Double> dataList =new ArrayList<Double>();
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m1").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m2").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m3").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m4").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m5").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m6").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m7").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m8").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m9").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m10").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m11").toString()):0D);
        dataList.add(retMap !=null?Double.valueOf(retMap.get("m12").toString()):0D);
        Setting setting = settingService.getSettingInfo();
        Map<String,Object> data =new HashMap<String, Object>();
        String name = ResourceUtils.getValueByLanguage("sale-money", setting.getLanguage());
        data.put("name",name);
        data.put("type","line");//折线图
        data.put("yAxisIndex",1);
        data.put("data",dataList);
        series.add(data);
        itemList.add(name);
        //分别对Max最低十为单位取整，用于构建Y轴最大值
        Map<String,Integer> YAxisMax=new HashMap<String, Integer>();
        YAxisMax.put("maxCount", CollectionUtils.isEmpty(maxCount)?0:DigitalUtil.convertLeastTenAsUnit(Collections.max(maxCount)));
        YAxisMax.put("saleMax",DigitalUtil.convertLeastTenAsUnit(Collections.max(dataList)));

        Map<String,Object> barChartData=new HashMap<String, Object>();
        barChartData.put("seriesData",series);
        barChartData.put("items",itemList);
        barChartData.put("YAxis",YAxisMax);
        return barChartData;
    }

    public Map<String, Object> getSalesAmountOfDay(Map<String, Object> params) {
        Map<String,Object> datas=new HashMap<String, Object>();
        LinkedList<String> dataNameList =new LinkedList<String>();
        LinkedList<Double> dataValueList =new LinkedList<Double>();
        double sum = 0;
        double total = 0;
        List<Map<String, Object>> resList =  orderDetailMapper.queryAmountMoneyOfType(params);
        
        Map<String, Object> retMap = orderMasterMapper.staTotalAmount(params);
        if(!CollectionUtils.isEmpty(retMap)) {
        	Map<String, Object> map1 = new HashMap<String, Object>();
        	Double totalAdultAmount = Double.valueOf(retMap.get("totalAdultAmount").toString());
        	Double totalChildAmount = Double.valueOf(retMap.get("totalChildAmount").toString());
        	Setting setting = settingService.getSettingInfo();
        	map1.put("name", ResourceUtils.getValueByLanguage("adult", setting.getLanguage()));
        	map1.put("value",totalAdultAmount);
        	resList.add(map1);
        	Map<String, Object> map2 = new HashMap<String, Object>();
        	map2.put("name", ResourceUtils.getValueByLanguage("child", setting.getLanguage()));
        	map2.put("value",totalChildAmount);
        	resList.add(map2);
        	total+=totalAdultAmount;
        	total+=totalChildAmount;
        }
        for (Map<String, Object> map : resList) {
        	String name = map.get("name").toString();
        	String value = map.get("value").toString();
        	dataNameList.addFirst(name);
            dataValueList.addFirst(Double.valueOf(value));
            sum+=Double.valueOf(value);
		}
        datas.put("nameList",dataNameList);
        datas.put("valueList",dataValueList);
        datas.put("sum",sum);
        total+=sum;
        datas.put("total",total);
        return datas;
    }
}
