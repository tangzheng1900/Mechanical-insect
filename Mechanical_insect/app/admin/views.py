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

# 上下文应用处理器
@admin.context_processor
def tpl_extra ():
    data = dict(online_time=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    return data

# 登录装饰器
def admin_login_req (f):
    @wraps(f)
    def decorated_function (*args, **kwargs):
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)
    return decorated_function


# 权限控制装饰器
def admin_auth (f):
    @wraps(f)
    def decorated_function (*args, **kwargs):
        admin = Admin.query.join(
            Role
        ).filter(
            Role.id == Admin.role_id,
            Admin.id == session['admin_id']
        ).first()
        auths = admin.role.auths
        # print(auths)
        # print('*'*100)
        auths = list(map(lambda v: int(v), auths.split(',')))
        auth_list = Auth.query.all()
        urls = [v.url for v in auth_list for val in auths if val == v.id]
        rule = request.url_rule
        # print(urls)
        # print(rule)
        if str(rule) not in urls:
            flash('您没有权限！请咨询管理员。', 'ok')
            abort(404)
        return f(*args, **kwargs)
    return decorated_function


# 系统管理
@admin.route("/")
@admin_login_req
def index ():
    return render_template("admin/index.html")

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
    return render_template("admin/login.html", form=form)

# 退出
@admin.route("/logout/")
@admin_login_req
def logout ():
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))