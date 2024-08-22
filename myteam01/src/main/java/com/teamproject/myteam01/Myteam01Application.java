package com.teamproject.myteam01;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.teamproject.myteam01.mapper")
public class Myteam01Application {

	public static void main(String[] args) {
		SpringApplication.run(Myteam01Application.class, args);
	}

}
