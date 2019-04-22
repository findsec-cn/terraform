# 在阿里云一键创建Kubernetes集群资源

## 概述

Terraform是一种开源工具，用于安全高效地预配和管理云基础结构。

HashiCorp Terraform 是一个IT基础架构自动化编排工具，可以用代码来管理维护IT资源。Terraform的命令行接口(CLI)提供一种简单机制，用于将配置文件部署到阿里云或其他任意支持的云上，并对其进行版本控制。

Terraform是一个高度可扩展的工具，通过Provider来支持新的基础架构。您可以使用Terraform来创建、修改、删除ECS、VPC、RDS、SLB等多种资源。

## 优势

- **将基础结构部署到多个云**

Terraform适用于多云方案，将相类似的基础结构部署到阿里云、其他云提供商或者本地数据中心。开发人员能够使用相同的工具和相似的配置文件同时管理不同云提供商的资源。

- **自动化管理基础结构**

Terraform能够创建配置文件的模板，以可重复、可预测的方式定义、预配和配置ECS资源，减少因人为因素导致的部署和管理错误。能够多次部署同一模板，创建相同的开发、测试和生产环境。

- **基础架构即代码（Infrastructure as Code）**

可以用代码来管理维护资源。允许保存基础设施状态，从而使您能够跟踪对系统（基础设施即代码）中不同组件所做的更改，并与其他人共享这些配置 。


## 安装和配置Terraform

1、前往[Terraform官网](https://www.terraform.io/downloads.html)下载适用于您的操作系统的程序包。

2、将程序包解压到/usr/local/bin。

3、运行terraform验证路径配置。

将显示可用的Terraform选项的列表，类似如下所示，表示安装完成。

    username:~$ terraform
    Usage: terraform [-version] [-help] <command> [args]

4、为提高权限管理的灵活性和安全性，建议您创建RAM用户，并为其授权。

- a. 登录 [RAM控制台](https://ram.console.aliyun.com/?spm=a2c63.p38356.879954.11.1aa1332eNuVkRH#/overview)。
- b. 创建名为Terraform的RAM用户，并为该用户创建AccessKey。
- c. 为RAM用户授权。需要为用户授予一下权限：

![RAM用户授权](https://github.com/findsec-cn/terraform/raw/master/imgs/ali_ram_auth.jpg)

5、创建环境变量，用于存放身份认证信息。这些变量可以放到/etc/bashrc里，登录自动生效。

    export ALICLOUD_ACCESS_KEY="LTAIUrZCw3********"
    export ALICLOUD_SECRET_KEY="zfwwWAMWIAiooj14GQ2*************"
    export ALICLOUD_REGION="cn-beijing"

## 创建资源

此项目将创建以下资源：

- 创建私有网络VPC及虚拟交换机
- 创建NAT网关、EIP和SNAT条目
- 创建1台堡垒机，可以通过堡垒机登录其它虚拟机
- 默认创建3个Master节点和3个Worker节点
- 创建负载均衡器SLB、监听及其使用的EIP

## 如何使用

- 可以按自己的需求修改`terraform.tfvars`配置的变量，包括虚拟机启动的地域、登录虚拟需要的SSH Key、VPC的网段、ECS的数量等等。
- 需要先在阿里云上创建一个秘钥对，秘钥对的名字要和terraform.tfvars定义的SSH_KEY_NAME对应。
- 运行terraform创建所需资源
- 资源创建好以后通过堡垒机外网IP登录堡垒机，然后将上面创建秘钥对使用的私钥拷贝的堡垒机的 $HOME/.ssh/id_rsa，并配置权限 chmod 600 $HOME/.ssh/id_rsa

## 运行terraform

### 初始化

    $ terraform init

### 查看要创建的资源

    $ terraform paln

### 创建资源

    $ terraform apply

### 销毁资源

    $ terraform destroy
