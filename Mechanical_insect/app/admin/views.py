# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 17:20
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : views.py
# @Software: PyCharm


from . import admin
from flask import render_template, redirect, url_for, flash, session, request,abort
from app.admin.forms import LoginForm
from app.database import Admin, User,  Oplog, Adminlog, Userlog, Auth, Role
from functools import wraps
from app import db, app
from werkzeug.utils import secure_filename
import os
import uuid
import datetime


# 系统管理
@admin.route("/")
def index ():
    return render_template("admin/test.html")

# 登录
@admin.route("/login/", methods=["GET", "POST"])
def login ():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin.query.filter_by(name=data["account"]).first()
        if not admin.check_pwd(data["pwd"]):
            flash("密码错误！", "err")
            return redirect(url_for("admin.login"))
        session["admin"] = data["account"]
        session["admin_id"] = admin.id
        adminlog = Adminlog(admin_id=admin.id, ip=request.remote_addr, )
        db.session.add(adminlog)
        db.session.commit()
        flash("登陆成功！", "ok")
        return redirect(request.args.get("next") or url_for("admin.index"))
    return render_template("admin/index.html", form=form)