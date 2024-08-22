package com.teamproject.myteam01.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySource("classpath:/application.yml")
//@PropertySource("classpath:/application-ojdbc-myuser.properties")
public class YourOjdbcHikariBeanConfig {

    //@Bean(name = "yourUserHikariConfig")
    //@Primary
    //@Qualifier("yourHikariConfigBean")
    //@ConfigurationProperties(prefix = "youruser.spring.datasource.hikari")
    //HikariConfig youruserHikariConfig() {
    //    return new HikariConfig();
    //}

    //@Bean(name = "yourUserDataSource")
    //@Qualifier("yourDataSourceBean")
    //DataSource yourDataSource(HikariConfig yourUserHikariConfig) {
    //    return new HikariDataSource(yourUserHikariConfig);
    //}

    @Bean(name = "myUserHikariConfig")
    @Qualifier("myUserHikariConfig")
    @ConfigurationProperties(prefix = "myuser.spring.datasource.hikari")
    HikariConfig myUserHikariConfig() {
        return new HikariConfig();
    }

    @Bean(name = "myUserDataSource")
    @Qualifier("myUserDataSource")
    DataSource myDataSource(@Qualifier("myUserHikariConfig") HikariConfig myUserHikariConfig) {
        return new HikariDataSource(myUserHikariConfig);
    }
}
