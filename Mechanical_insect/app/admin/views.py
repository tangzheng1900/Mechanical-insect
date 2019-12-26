# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 17:20
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : views.py
# @Software: PyCharm


from . import admin
from flask import render_template, redirect, url_for, flash, session, request,abort
from app.admin.forms import LoginForm,AdminForm,RoleForm
from app.models import Admin, User,  Oplog, Adminlog, Userlog, Auth, Role
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


# 管理员列表
@admin.route("/admin/list/<int:page>/",  methods=["GET", "POST"])
@admin_login_req
def admin_list (page=None):
    form = AdminForm()
    if page is None:
        page = 1
    page_data = Admin.query.order_by(
        Admin.addtime.desc()
    ).join(
        Role
    ).filter(
        Role.id==Admin.role_id
    ).paginate(page=page, per_page=10)
    from werkzeug.security import generate_password_hash
    if form.validate_on_submit():
        data = form.data
        admin = Admin(
            name=data["name"],
            pwd=generate_password_hash(data["pwd"]),
            role_id=data["role_id"],
            is_super=1
        )
        db.session.add(admin)
        db.session.commit()
        flash("添加管理员成功！", "ok")
    return render_template("admin/admin_list.html",page_data=page_data,form=form)

# 添加管理员
@admin.route("/admin/add/", methods=["GET", "POST"])
@admin_login_req
def admin_add ():
    form=AdminForm()
    from werkzeug.security import generate_password_hash
    if form.validate_on_submit():
        data= form.data
        admin=Admin(
            name=data["name"],
            pwd =generate_password_hash(data["pwd"]),
            role_id= data["role_id"],
            is_super=1
        )
        db.session.add(admin)
        db.session.commit()
        flash("添加管理员成功！","ok")
    return render_template("admin/admin_list.html",form=form)


# 角色列表
@admin.route("/role/list/<int:page>/", methods=['GET'])
@admin_login_req

def role_list (page=None):
    if page is None:
        page = 1
    page_data = Role.query.order_by(Role.addtime.desc()).paginate(page=page, per_page=10)
    return render_template("admin/role_list.html", page_data=page_data)

# 角色删除
@admin.route("/role/del/<int:id>/", methods=["GET"])
@admin_login_req

def role_del (id=None):
    role = Role.query.get_or_404(int(id))
    db.session.delete(role)
    db.session.commit()
    flash("删除角色成功！", "ok")
    return redirect(url_for("admin.role_list", page=1))


# 编辑角色
@admin.route("/role/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req

def role_edit (id=None):
    form = RoleForm()
    role = Role.query.get_or_404(id)
    if request.method == "GET":
        auths = role.auths
        form.auths.data = list(map(lambda v: int(v), auths.split(",")))
    if form.validate_on_submit():
        data = form.data
        role.auths = ','.join(map(lambda v: str(v), data['auths']))
        role.name = data["name"]
        db.session.add(role)
        db.session.commit()
        flash("编辑角色成功！", "ok")
        return redirect(url_for('admin.role_edit', id=id))
    return render_template("admin/role_edit.html", form=form, role=role)