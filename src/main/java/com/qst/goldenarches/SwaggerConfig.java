package com.qst.goldenarches;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableWebMvc
@EnableSwagger2
@ComponentScan(basePackages="com.qst.goldenarches.controller")
public class SwaggerConfig {
	@Bean
    public Docket api(){
		
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(this.apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.qst.goldenarches.controller"))
                .paths(PathSelectors.any())
                .build();
        
    }
    

    private ApiInfo apiInfo(){  
    	
        @SuppressWarnings("deprecation")        
        ApiInfo info = new ApiInfo(
                 "",
                 "",
                 "",
                 "",
                 "",
                 "",
                 "");
         return info;               
         
    }
}
