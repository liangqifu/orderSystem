package com.qst.goldenarches;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

import com.alibaba.fastjson.serializer.BeanContext;
import com.alibaba.fastjson.serializer.BigDecimalCodec;
import com.alibaba.fastjson.serializer.ContextObjectSerializer;
import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.SerializeWriter;

public class CustomerBigDecimalCodec extends BigDecimalCodec implements ContextObjectSerializer {

    public final static CustomerBigDecimalCodec instance = new CustomerBigDecimalCodec();

    /**
     * 当BigDecimal类型的属性上有@JsonFiled注解，且该注解中的format有值时，使用该方法进行序列化，否则使用fastjson的
     * BigDecimalCodec中的write方法进行序列化
     */
    @Override
    public void write(JSONSerializer serializer, Object object, BeanContext context){
        SerializeWriter out = serializer.out;
        if(object == null) {
        	out.writeString("");;
        }else {
            out.writeString(formatToNumber((BigDecimal)object));	
        }
        
    }
    
    private  String formatToNumber(BigDecimal obj) {
		DecimalFormat df = new DecimalFormat("#.00");
		df.setRoundingMode(RoundingMode.HALF_UP);
		if(obj.compareTo(BigDecimal.ZERO)==0) {
			return "0.00";
		}else if(obj.compareTo(BigDecimal.ZERO)>0&&obj.compareTo(new BigDecimal(1))<0){
			return "0"+df.format(obj).toString();
		}else {
			return df.format(obj).toString();
		}
	}


}
