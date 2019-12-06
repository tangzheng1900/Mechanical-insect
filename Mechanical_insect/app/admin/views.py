# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 17:20
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : views.py
# @Software: PyCharm


from . import admin
from flask import render_template, redirect, url_for, flash, session, request,abort



# 系统管理
@admin.route("/")
def index ():
    return render_template("admin/index.html")