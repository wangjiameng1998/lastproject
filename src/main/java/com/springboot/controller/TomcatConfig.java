package com.springboot.controller;

import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;

/**
 * Created by  on 2019/4/20 0020.
 * ！！！！！！！！！！！！！！！！！可以直接访问jsp文件
 */
@Configuration
public class TomcatConfig {
    @Bean
    public ConfigurableServletWebServerFactory configurableServletWebServerFactory() {
        TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory();
        factory.setDocumentRoot(new File("D:\\workspace\\lastproject\\src\\main\\resources\\templates"));
        return factory;
    }
}
