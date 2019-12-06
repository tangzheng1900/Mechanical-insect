# -*- coding: utf-8 -*-
# @Time    : 2019/2/11 15:48
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : __init__.py.py
# @Software: PyCharm


from flask import Blueprint # 导入蓝图


# 1. 创建蓝图对象 (蓝图就是抽象的功能模块，模块化)
# 第一个参数是蓝图的名字，第二个参数表示蓝图的根目录(__name__当前模块所在目录)
# 第三、四个参数指定模板目录和静态资源目录。(查找模板时，先在项目中的目录中查找，找不到再去蓝图对应目录中查找)
# app_goods = Blueprint("goods", __name__, template_folder="templates", static_folder="static")


home =Blueprint("home",__name__)

import app.admin.views