# mybatis-plus代码生成器

项目中使用mybatis-plus代码生成器(新),可以根据数据表的结构,生成entity、mapper、service、controller等代码，提高开发效率。

这里整理了一些常用的配置，并自定义模板文件，具体的配置可以参考官方文档。

## 完整配置参考

[https://baomidou.com/guides/new-code-generator](https://baomidou.com/guides/new-code-generator/)

## 使用步骤

1. 代码根据数据表生成，所以需要先创建数据库和表
2. 修改单元测试类中的数据库连接配置

```
FastAutoGenerator.create("jdbc:mysql://localhost:3306/your_database?useUnicode=true?characterEncoding=UTF-8&serverTimeZone=Asia/Shanghai",
                                 "your_user",
                                 "your_password")
                                 ...
```

3. 运行单元测试类
    ```bash
       mvn clean test
    ```
4. 在项目目录下生成各层代码

## 注意

- 项目使用的JDK为17、SpringBoot3,各依赖均已适配SpringBoot3
- 其他较新版本未经过测试，如有问题请自行解决

## 自定义

- 可以根据自己的需要修改模板文件，模板文件在resources/templates下
