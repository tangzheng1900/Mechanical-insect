# -*- coding: utf-8 -*-
# @Time    : 2020/3/24 14:17
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : NacosConfig.py
# @Software: PyCharm

import nacos
import configparser
from io import StringIO
import os

SERVER_ADDRESSES = "172.16.27.35:8848"  # Nacos地址
NAMESPACE = "e80948bd-9118-450e-9ea4-9c9024ce080a"  # 项目识别码

client = nacos.NacosClient(SERVER_ADDRESSES, namespace=NAMESPACE)

# get config
data_id = "interface_auto_cases"  # data id
group = "DEFAULT_GROUP"  # Group
nacos_conf = client.get_config(data_id, group)  # 所有配置项
# print(nacos_conf)

conf = configparser.ConfigParser()  # 配置读取实例
conf.read_file(StringIO(nacos_conf))  # 模拟器读取

config = eval(conf.get("DBCONFIG", "config"))  # 获取平台数据库

path = conf.get("PROJECT_PATH", "project_path")  # 服务器路径
path1 = conf.get("PROJECT_PATH", "project_path1")  # 本地路径

table = conf.get("DBTABLE", "table")  # 表对应关系

log_path = os.path.join(path1, "Result", 'log')  # 日志存储的路径
# print(log_path)

html_path = os.path.join(path1, "Result", 'htmlreport')  # html报告的路径
# print(html_path)

test_data_path = os.path.join(path1, "test_data", "interface_cases.xlsx")  # 注册测试数据的路径
# print(test_data_path)
