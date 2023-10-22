package com.cms.document.config;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import javax.servlet.MultipartConfigElement;

/**
 * @Classname ConfigFile
 * @Description 定义文件配置内容
 * @Date 2023/10/21 10:36
 * @Created by Matrix
 */
@Configuration
public class ConfigFile {


    /***
     * 配置文件上传大小
     * @return
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize(DataSize.ofMegabytes(1024));
        factory.setMaxRequestSize(DataSize.ofMegabytes(1024));
        return factory.createMultipartConfig();
    }


}
