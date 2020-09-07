# -*- coding: utf-8 -*-
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : Allpath.py
# @Software: PyCharm

import os
from interface_auto_cases.public.config import readConfig
import interface_auto_cases.conf.NacosConfig as NC

# path_conf_path=os.path.join(os.path.split(os.path.realpath(__file__))[0],'path.conf')
# #print(path_conf_path)

# 项目地址
project_path = NC.path1
# print(project_path)


# http配置文件的路径
http_conf_path = os.path.join(project_path, "conf", "http.conf")
# print(http_conf_path)


# 用例执行配置文件路径
case_conf_path = os.path.join(project_path, "conf", "case.conf")
# print(case_conf_path)


# 邮件配置文件路径
smtp_conf_path = os.path.join(project_path, "conf", "smtpconf.conf")
# print(case_conf_path)


# 数据库配置文件路径
db_conf_path = os.path.join(project_path, "conf", "db.conf")
# print(db_conf_path)


# 注册测试数据的路径
test_data_path = os.path.join(project_path, "test_data", "interface_cases.xlsx")
# print(test_data_path)


# 日志存储的路径
log_path = os.path.join(project_path, "Result", 'log')
# print(log_path)


# html报告的路径
html_path = os.path.join(project_path, "Result", 'htmlreport')
# print(test_data_path)
