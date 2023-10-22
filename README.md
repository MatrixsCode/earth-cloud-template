
                                 
### DT MICRO 平台

 **Spring Cloud Alibaba全套分布式微服务，前后端分离架构，大道至简、代码玄学、开箱即用**  <br>

![SpringBoot版本](https://img.shields.io/badge/spring--boot-2.3.2-brightgreen.svg "SpringBoot版本") 
![SpringCloud版本](https://img.shields.io/badge/spring-cloud--Hoxton.SR9-brightgreen.svg "SpringCloud版本]")
![SpringCloudAlibaba版本](https://img.shields.io/badge/spring-cloud--alibaba--2.2.6-brightgreen.svg "SpringCloudAlibaba版本")
![seata版本](https://img.shields.io/badge/seata-1.4.2-brightgreen.svg "seata版本")
![OAuth2版本](https://img.shields.io/badge/oauth2-2.2.5-brightgreen.svg "OAuth2版本")
![canal版本](https://img.shields.io/badge/canal-1.1.4-brightgreen.svg "canal版本")
![flowable版本](https://img.shields.io/badge/flowable-6.7.1-brightgreen.svg "flowable版本")
![quartz版本](https://img.shields.io/badge/quartz-2.3.5-brightgreen.svg "quartz版本")
![输入图片说明](https://img.shields.io/badge/MySQL-8.0.81-brightgreen "在这里输入图片标题") 
![输入图片说明](https://img.shields.io/badge/redis-6.0.6-brightgreen "在这里输入图片标题")
![输入图片说明](https://img.shields.io/badge/mybatisplus-3.4.6-brightgreen "在这里输入图片标题")
![输入图片说明](https://img.shields.io/badge/easyexcel-2.2.0beta2-brightgreen "在这里输入图片标题")
![输入图片说明](https://img.shields.io/badge/Vue-3.5.0-brightgreen "在这里输入图片标题")  
 

# 平台简介

 **DT MICRO**  是一套SpringCloud微服务架构设计的后台管理系统，追求 **快速的用户体验** 、 **二次编码** ，以及 **核心技术模块的整合** 使用。后端新技术框架的加持、前端UI的设计与美化，会持续升级，持续完善，欢迎亲友们收藏、点赞和转发。

## 核心技术

框架组成SpringCloud、Nacos、GateWay、Sentinel、Seata、Oauth2.0，消息队列采用RabbitMQ，数据库采用MySQL、Redis，mongodb，文件服务器：Minio，前端UI：Vue3、ElementUI

## 部署管理
#### 1、新建命名空间
下载安装好Nacos之后，登录Nacos控制台，新建命名空间【micro】，生成命名空间ID。

![输入图片说明](doc/images/1.png)

注意：生成命名空间ID

![输入图片说明](doc/images/2.png)

#### 2、导入Nacos配置文件
在本项目的根目录doc/config目录下，选择nacos_config_export_20230329154502.zip导入到上一步新建的目标空间【micro】中

![输入图片说明](doc/images/3.png)

#### 3、修改MySQL以及Redis
修改自己本地的MySQL以及Redis的连接配置信息

![输入图片说明](doc/images/4.png)

注意：将源码根目录doc/sql目录下的sql文件【dt_micro.sql】导入到自己的MySQL库中
#### 4、修改源码bootstrap.yml配置文件
将第一步中生成的命名空间ID，填写至每个服务的配置文件中，并且记得修改Nacos地址，比如我的是本地安装的，端口使用的也是默认的，根据自己安装的需求修改即可。

![输入图片说明](doc/images/5.png)

#### 5、启动后端服务
依次启动如下三个微服务即可：

![输入图片说明](doc/images/6.png)

