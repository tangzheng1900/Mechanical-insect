# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 17:20
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : views.py
# @Software: PyCharm


from . import admin
from flask import render_template, redirect, url_for, flash, session, request,abort
from app.admin.forms import LoginForm,AdminForm,RoleForm,AuthFrom
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
            flash('您没有权限！请咨询管理员。', 'err')
            abort(404)
        return f(*args, **kwargs)
    return decorated_function


# 系统管理
@admin.route("/")
@admin_login_req
@admin_auth
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
        if not admin.state==0:
            flash("账号已停用，联系管理员！", "err")
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
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="退出系统")
    db.session.add(oplog)
    db.session.commit()
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))


# 管理员列表
@admin.route("/admin/list/<int:page>/",  methods=["GET", "POST"])
@admin_login_req
@admin_auth
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
    if form.validate_on_submit():
        data = form.data
        admin_add(data)
    return render_template("admin/admin_list.html",page_data=page_data,form=form)


#管理员状态
@admin.route("/admin/state/<int:id><int:state>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def admin_state (id=None,state=None):
    admin = Admin.query.get_or_404(id)
    if id==1:
        flash("无权停用，联系管理员！", "err")
        return redirect(url_for("admin.admin_list", page=1))
    if state==0:
        admin.state = 1
        flash("停用角色成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="停用角色%s" % id)
        db.session.add(oplog)
        db.session.commit()
    else:
        admin.state = 0
        flash("启用角色成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="启用角色%s" % id)
        db.session.add(oplog)
        db.session.commit()
    db.session.add(admin)
    db.session.commit()
    return redirect(url_for("admin.admin_list", page=1))


# 添加管理员
@admin.route("/admin/add/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def admin_add (data):
    # print(data)
    from werkzeug.security import generate_password_hash
    admin=Admin(
        name=data["name"],
        pwd =generate_password_hash(data["pwd"]),
        role_id= data["role_id"],
        is_super=1,
        state=0
    )
    db.session.add(admin)
    db.session.commit()
    flash("添加管理员成功！","ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加管理员%s" % data["name"])
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.admin_list", page=1))


# 管理员删除
@admin.route("/admin/del/<int:id>/", methods=["GET","POST"])
@admin_login_req
@admin_auth
def admin_del (id=None):
    if id==1:
        flash("无权删除，联系管理员！", "err")
        return redirect(url_for("admin.admin_list", page=1))
    admin = Admin.query.get_or_404(int(id))
    db.session.delete(admin)
    db.session.commit()
    flash("删除角色成功！", "ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="删除管理员%s" % id)
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.admin_list", page=1))


# 添加角色
@admin.route("/role/add/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def role_add (data):
    # print(data)
    if Role.query.filter_by(name=data['name']).count() == 1:
        flash('角色名称已存在！', category='err')
        return redirect(url_for('admin.role_list'))
    role = Role(name=data['name'], auths=','.join(map(lambda v: str(v), data['auths'])))
    db.session.add(role)
    db.session.commit()
    flash("添加角色成功！", "ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加角色%s" % data['name'])
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.role_list", page=1))


# 角色列表
@admin.route("/role/list/<int:page>/", methods=['GET', "POST"])
@admin_login_req
@admin_auth
def role_list (page=None):
    form = RoleForm()
    if page is None:
        page = 1
    page_data = Role.query.order_by(Role.addtime.desc()).paginate(page=page, per_page=10)
    if form.validate_on_submit():
        data = form.data
        role_add(data)
    return render_template("admin/role_list.html", page_data=page_data, form=form)

# 角色删除
@admin.route("/role/del/<int:id>/", methods=["GET"])
@admin_login_req
@admin_auth
def role_del (id=None):
    if id == 1:
        flash("无权删除，联系管理员！", "err")
        return redirect(url_for("admin.role_list", page=1))
    role = Role.query.get_or_404(int(id))
    db.session.delete(role)
    db.session.commit()
    flash("删除角色成功！", "ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="删除角色%s" % id)
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.role_list", page=1))


# 编辑角色
@admin.route("/role/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def role_edit (id=None):
    if id == 1:
        flash("无权编辑，联系管理员！", "err")
        return redirect(url_for("admin.role_list", page=1))
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
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="编辑角色%s" % id)
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for('admin.role_list',page=1))
    return render_template("admin/role_edit.html", form=form, role=role)


# 权限列表
@admin.route("/auth/list/<int:page>/", methods=['GET', "POST"])
@admin_login_req
@admin_auth
def auth_list (page=None):
    form = AuthFrom()
    data = form.data
    if page is None:
        page = 1
    page_data = Auth.query.order_by(Auth.addtime.desc()).paginate(page=page, per_page=10)
    if form.validate_on_submit():
        if form.submit.data:
            auth_add(data)
    return render_template("admin/auth_list.html", page_data=page_data, form=form)

# 添加权限
@admin.route("/auth/add/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def auth_add (data):
    if Auth.query.filter_by(url=data['url']).count() == 1:
        flash('权限链接地址已存在！', category='err')
        return redirect(url_for('admin.auth_list'))
    if Auth.query.filter_by(name=data['name']).count() == 1:
        flash('权限名称已存在！', category='err')
        return redirect(url_for('admin.auth_list'))
    auth = Auth(name=data["name"], url=data["url"])
    db.session.add(auth)
    db.session.commit()
    flash("添加权限成功！", "ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加权限%s" % data['name'])
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.auth_list", page=1))


# 编辑权限
@admin.route("/auth/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def auth_edit (id=None):
    form = AuthFrom()
    auth = Auth.query.get_or_404(id)
    if form.edit.data:
        data = form.data
        if Auth.query.filter_by(url=data['url']).count() == 1:
            flash('权限链接地址已存在！', category='err')
            return redirect(url_for('admin.auth_edit', id=id))
        if Auth.query.filter_by(name=data['name']).count() == 1:
            flash('权限名称已存在！', category='err')
            return redirect(url_for('admin.auth_edit', id=id))
        auth.url = data['url']
        auth.name = data["name"]
        db.session.add(auth)
        db.session.commit()
        flash("修改权限成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="修改权限%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
        return redirect(url_for('admin.auth_list', page=1))
    return render_template("admin/auth_edit.html", form=form, auth=auth)


# 权限删除
@admin.route("/auth/del/<int:id>/", methods=["GET"])
@admin_login_req
@admin_auth
def auth_del (id=None):
    auth = Auth.query.get_or_404(int(id))
    db.session.delete(auth)
    db.session.commit()
    flash("删除权限成功！", "ok")
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="删除权限%s" % id)
    db.session.add(oplog)
    db.session.commit()
    return redirect(url_for("admin.auth_list", page=1))


# 操作日志列表
@admin.route("/oplog/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def oplog_list (page=None):
    if page is None:
        page = 1
    page_data = Oplog.query.join(Admin).filter(Admin.id == Oplog.admin_id, ).order_by(Oplog.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/oplog_list.html", page_data=page_data)


# 管理员登录日志列表
@admin.route("/adminloginlog/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def adminloginlog_list (page=None):
    if page is None:
        page = 1
    page_data = Adminlog.query.join(Admin).filter(Admin.id == Adminlog.admin_id, ).order_by(
        Adminlog.addtime.desc()).paginate(page=page, per_page=10)
    return render_template("admin/adminloginlog_list.html", page_data=page_data)


# 会员登录日志列表
@admin.route("/userloginlog/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def userloginlog_list (page=None):
    if page is None:
        page = 1
    page_data = Userlog.query.join(User).filter(User.id == Userlog.user_id, ).order_by(Userlog.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/userloginlog_list.html", page_data=page_data)



