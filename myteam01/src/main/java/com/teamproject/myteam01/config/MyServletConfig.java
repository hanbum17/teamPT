package com.teamproject.myteam01.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.teamproject.myteam01.MyTeam01BasePackage;


@Configuration
@ComponentScan(basePackageClasses = { MyTeam01BasePackage.class})
public class MyServletConfig {
    //@Bean
    //public WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> yourWebServerFactoryCustomizer(){
    //    return factory -> factory.setContextPath("/yourpro00");
    //}
}
