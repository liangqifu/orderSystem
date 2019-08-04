package com.qst.goldenarches.utils;

import java.util.Locale;

import org.springframework.context.support.ReloadableResourceBundleMessageSource;

/**
 * 国际化配置文件
 * 
 * @author Administrator
 *
 */
public class ResourceUtils {

	private static ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();

	static {
		// 指定国家化资源文件路径
		messageSource.setBasename("i18n/message");
		// 指定将用来加载对应资源文件时使用的编码，默认为空，表示将使用默认的编码进行获取。
		messageSource.setDefaultEncoding("UTF-8");

		// 是否允许并发刷新
		messageSource.setConcurrentRefresh(true);

		// ReloadableResourceBundleMessageSource也是支持缓存对应的资源文件的，默认的缓存时间为永久，即获取了一次资源文件后就将其缓存起来，以后再也不重新去获取该文件。这个可以通过setCacheSeconds()方法来指定对应的缓存时间，单位为秒
		messageSource.setCacheSeconds(1200);
	}

	public static String getChineseValueByKey(String key) {

		return messageSource.getMessage(key, null, Locale.CHINA);
	}

	public static String getGermanValueByKey(String key) {

		return messageSource.getMessage(key, null, Locale.GERMANY);
	}

	public static String getEnglishValueByKey(String key) {

		return messageSource.getMessage(key, null, Locale.US);
	}

	public static String getValueByLanguage(String key,String language) {
		if("de_DE".equals(language)) {
			return getGermanValueByKey(key);
		}else if("en_US".equals(language)) {
			return getEnglishValueByKey(key);
		}else {
			return getChineseValueByKey(key);
		}
	}
	
	public static String getValueAndPlaceholder(String key) {

		return messageSource.getMessage(key, new Object[] { "安全" }, null);
	}
}
