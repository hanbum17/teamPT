package com.teamproject.myteam01.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenAPIConfig {
	
	@Bean
	public OpenAPI oepnAPI() {
		  
		Info info = new Info()
				.version("v1")
				.title("Swagger Test")
				.description("스웨거 테스트입니다.");
		
		return new OpenAPI().info(info);
	}
	
}
