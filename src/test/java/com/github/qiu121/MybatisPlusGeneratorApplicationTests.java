package com.github.qiu121;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import org.apache.ibatis.annotations.Mapper;
import org.junit.jupiter.api.Test;

import java.util.Collections;

class MybatisPlusGeneratorApplicationTests {

    @Test
    void contextLoads() {
        String finalProjectPath = System.getProperty("user.dir");
        System.out.println("当前工作目录：" + finalProjectPath);

        FastAutoGenerator.create("jdbc:mysql://localhost:3306/test?useUnicode=true?characterEncoding=UTF-8&serverTimeZone=Asia/Shanghai",
                        "root",
                        "root")
                .globalConfig(builder -> {
                    builder.author("to_Geek") // 设置作者
                            // .enableSpringdoc() // 开启 swagger/springdoc 模式
                            // .fileOverride()
                            .disableOpenDir() // 禁止打开输出目录
                            .commentDate("yyyy/MM/dd")
                            .outputDir(finalProjectPath + "/src/main/java"); // 指定输出目录
                })
                .strategyConfig(builder -> {
                    builder.entityBuilder().enableLombok()
                            .enableFileOverride()// 覆盖已生成文件
                            .idType(IdType.AUTO)// 全局主键类型
                            // .enableChainModel() // 开启链式模型
                            // .enableTableFieldAnnotation()//开启实体类字段注解
                            .controllerBuilder().enableRestStyle()
                            .mapperBuilder()
                            // .enableBaseColumnList()// 通用查询结果列
                            // .enableBaseResultMap()// 通用查询映射结果
                            .mapperAnnotation(Mapper.class);
                })
                .packageConfig(builder -> {
                    builder.parent("com.github.qiu121") // 设置父包名
                            .entity("entity")// 设置entity包名;
                            .pathInfo(Collections.singletonMap(OutputFile.xml, finalProjectPath + "/src/main/resources/mapper")); // 设置mapperXml生成路径
                    // .moduleName("test") // 设置父包模块名

                })
                // .templateConfig(builder -> {
                //     builder.mapper("templates")
                // })
                .templateEngine(new FreemarkerTemplateEngine())// 使用Freemarker引擎模板，默认的是Velocity引擎模板
                .execute();
    }

}
