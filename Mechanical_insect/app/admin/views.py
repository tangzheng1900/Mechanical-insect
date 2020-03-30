# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 17:20
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : views.py
# @Software: PyCharm


from . import admin
from flask import render_template, redirect, url_for, flash, session, request, abort
from app.admin.forms import LoginForm, AdminForm, RoleForm, AuthFrom, ProjectFrom, CaseFrom, EnvironmentFrom
from app.models import Admin, User, Oplog, Adminlog, Userlog, Auth, Role, Project, Case, Environment
from functools import wraps
from werkzeug.security import generate_password_hash
from app import db
import datetime

user_list = User.query.all()

# 上下文应用处理器
@admin.context_processor
def tpl_extra():
    data = dict(online_time=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    return data


# 登录装饰器
def admin_login_req(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 权限控制装饰器
def admin_auth(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
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
def index():
    return render_template("admin/admin.html")
@admin.route("/home/")
def home():
    return render_template("admin/welcome1.html")
@admin.route("/home1/")
def home1():
    return render_template("admin/homepage1.html")
@admin.route("/home2/")
def home2():
    return render_template("admin/homepage2.html")


# 登录
@admin.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin.query.filter_by(name=data["account"]).first()
        if not admin.check_pwd(data["pwd"]):
            flash("密码错误！", "err")
            return redirect(url_for("admin.login"))
        if not admin.state == 0:
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
def logout():
    oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="退出系统")
    db.session.add(oplog)
    db.session.commit()
    session.pop("admin", None)
    session.pop("admin_id", None)
    return redirect(url_for("admin.login"))


# 管理员列表
@admin.route("/admin/list/<int:page>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def admin_list(page=None):
    form = AdminForm()
    if page is None:
        page = 1
    page_data = Admin.query.order_by(
        Admin.addtime.desc()
    ).join(
        Role
    ).filter(
        Role.id == Admin.role_id
    ).paginate(page=page, per_page=10)
    return render_template("admin/admin_list.html", page_data=page_data, form=form)


# 管理员状态
@admin.route("/admin/state/<int:id><int:state>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def admin_state(id=None, state=None):
    admin = Admin.query.get_or_404(id)
    if id == 1:
        flash("无权停用，联系管理员！", "err")
        return redirect(url_for("admin.admin_list", page=1))
    if state == 0:
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
def admin_add():
    form = AdminForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin(
            name=data["name"],
            pwd=generate_password_hash(data["pwd"]),
            role_id=data["role_id"],
            state=0,
            is_super=1
        )
        db.session.add(admin)
        db.session.commit()
        flash("添加管理员成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加管理员%s" % data["name"])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/admin_add.html", form=form)


# 管理员删除
@admin.route("/admin/del/<int:id>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def admin_del(id=None):
    if id == 1:
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
def role_add():
    form = RoleForm()
    if form.validate_on_submit():
        data = form.data
        # print(data)
        if Role.query.filter_by(name=data['name']).count() == 1:
            flash('角色名称已存在！', category='err')
            return redirect(url_for('admin.role_add'))
        role = Role(name=data['name'], auths=','.join(map(lambda v: str(v), data['auths'])))
        db.session.add(role)
        db.session.commit()
        flash("添加角色成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加角色%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/role_add.html", form=form)


# 角色列表
@admin.route("/role/list/<int:page>/", methods=['GET', "POST"])
@admin_login_req
@admin_auth
def role_list(page=None):
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
def role_del(id=None):
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
def role_edit(id=None):
    if id == 1:
        flash("无权编辑，联系管理员！", "err")
        return abort(404)
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
        return redirect(url_for('admin.role_list', page=1))
    return render_template("admin/role_edit.html", form=form, role=role)


# 权限列表
@admin.route("/auth/list/<int:page>/", methods=['GET', "POST"])
@admin_login_req
@admin_auth
def auth_list(page=None):
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
def auth_add():
    form = AuthFrom()
    if form.validate_on_submit():
        data = form.data
        if Auth.query.filter_by(url=data['url']).count() == 1:
            flash('权限链接地址已存在！', category='err')
            return redirect(url_for('admin.auth_add'))
        if Auth.query.filter_by(name=data['name']).count() == 1:
            flash('权限名称已存在！', category='err')
            return redirect(url_for('admin.auth_add'))
        auth = Auth(name=data["name"], url=data["url"])
        db.session.add(auth)
        db.session.commit()
        flash("添加权限成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加权限%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/auth_add.html", form=form)


# 编辑权限
@admin.route("/auth/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
@admin_auth
def auth_edit(id=None):
    form = AuthFrom()
    auth = Auth.query.get_or_404(id)
    if form.validate_on_submit():
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
def auth_del(id=None):
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
def oplog_list(page=None):
    if page is None:
        page = 1
    page_data = Oplog.query.join(Admin).filter(Admin.id == Oplog.admin_id, ).order_by(Oplog.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/oplog_list.html", page_data=page_data)


# 管理员登录日志列表
@admin.route("/adminloginlog/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def adminloginlog_list(page=None):
    if page is None:
        page = 1
    page_data = Adminlog.query.join(Admin).filter(Admin.id == Adminlog.admin_id, ).order_by(
        Adminlog.addtime.desc()).paginate(page=page, per_page=10)
    return render_template("admin/adminloginlog_list.html", page_data=page_data)


# 会员列表
@admin.route("/user/list/<int:page>/", methods=["GET"])
@admin_login_req
@admin_auth
def user_list(page=None):
    if page is None:
        page = 1
    page_data = User.query.order_by(User.addtime.desc()).paginate(page=page, per_page=10)
    return render_template("admin/user_list.html", page_data=page_data)


# 查看会员
@admin.route("/user/view/<int:id>", methods=["GET"])
@admin_auth
@admin_login_req
def user_view(id=None):
    user = User.query.get_or_404(int(id))
    return render_template("admin/user_view.html", user=user)


# 会员删除
@admin.route("/user/del/<int:id>/", methods=["GET"])
@admin_login_req
@admin_auth
def user_del(id=None):
    user = User.query.get_or_404(int(id))
    db.session.delete(user)
    db.session.commit()
    flash("删除预告成功！", "ok")
    return redirect(url_for("admin.user_list", page=1))


# 会员登录日志列表
@admin.route("/userloginlog/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def userloginlog_list(page=None):
    if page is None:
        page = 1
    page_data = Userlog.query.join(User).filter(User.id == Userlog.user_id, ).order_by(Userlog.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/userloginlog_list.html", page_data=page_data)


# 项目列表
@admin.route("/project/list/<int:page>/", methods=['GET'])
@admin_login_req
@admin_auth
def project_list(page=None):
    if page is None:
        page = 1
    page_data = Project.query.join(User).filter(User.id == Project.leader).order_by(Project.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/project_list.html", page_data=page_data)


# 项目状态
@admin.route("/project/status/<int:id>/<int:status>", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def project_status(id=None, status=None):
    project = Project.query.get_or_404(id)
    # if id == 1:
    #     flash("无权停用，联系管理员！", "err")
    #     return redirect(url_for("admin.admin_list", page=1))
    if status == 0:
        project.status = 1
        flash("停用项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="停用项目%s" % id)
        db.session.add(oplog)
        db.session.commit()
    else:
        project.status = 0
        flash("启用项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="启用项目%s" % id)
        db.session.add(oplog)
        db.session.commit()
    db.session.add(project)
    db.session.commit()
    return redirect(url_for("admin.project_list", page=1))

# 添加项目
@admin.route("/project/add/", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def project_add():
    form = ProjectFrom()
    if form.validate_on_submit():
        data = form.data
        if Project.query.filter_by(name=data['name']).count() == 1:
            flash('项目名称已存在！', category='err')
            return redirect(url_for('admin.project_add'))
        elif Project.query.filter_by(name=data['version']).count() == 1:
            flash('项目编号已存在！', category='err')
            return redirect(url_for('admin.project_add'))

        project = Project(name=data["name"], version=data["version"], models=data["models"], user_id=session["admin"],
                          leader=data["leader"], comment=data["comment"], case_num='', execute_count='', case_pass='',
                          status=0)

        db.session.add(project)
        db.session.commit()
        flash("添加项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加项目：%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/project_add.html", form=form)


# 项目删除
@admin.route("/project/del/<int:id>/<int:status>", methods=["GET"])
@admin_login_req
# @admin_auth
def project_del(id=None, status=None):
    project = Project.query.get_or_404(int(id))
    if status == 0:
        flash('项目正在使用！', category='err')
        return redirect(url_for('admin.project_list', page=1))
    db.session.delete(project)
    db.session.commit()
    flash("删除项目成功！", "ok")
    return redirect(url_for("admin.project_list", page=1))


# 项目修改
@admin.route("/project/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def project_edit(id=None):
    form = ProjectFrom()
    project = Project.query.get_or_404(id)
    if form.validate_on_submit():
        data = form.data
        if Project.query.filter_by(name=data['name']).count() == 1:
            flash('项目名称已存在！', category='err')
            return redirect(url_for('admin.project_edit'))
        elif Project.query.filter_by(name=data['version']).count() == 1:
            flash('项目编号已存在！', category='err')
            return redirect(url_for('admin.project_edit'))
        project.version = data['version']
        project.name = data["name"]
        project.models = data["models"]
        project.leader = data["leader"]
        project.comment = data["comment"]
        db.session.add(project)
        db.session.commit()
        flash("修改项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="修改项目%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
        return render_template("admin/project_edit.html", form=form, project=project)
    return render_template("admin/project_edit.html", form=form, project=project)


# 用例列表
@admin.route("/case/list/<int:page>/", methods=['GET'])
@admin_login_req
# @admin_auth
def case_list(page=None):
    if page is None:
        page = 1
    page_data = Case.query.join(User).filter(User.id == Case.case_leader, ).order_by(Case.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/case_list.html", page_data=page_data)


# 用例测试
@admin.route("/case/run/<string:version>", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def case_run(version=None):
    import interface_auto_cases.main as ma
    test=ma.run(version)
    flash(test, "ok")
    return redirect(url_for('admin.case_list', page=1))


# 添加用例
@admin.route("/case/add/", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def case_add():
    form = CaseFrom()
    if form.validate_on_submit():
        data = form.data
        if Case.query.filter_by(cases_name=data['cases_name']).count() == 1:
            flash('用例名称已存在！', category='err')
            return redirect(url_for('admin.case_add'))
        case = Case(cases_name=data["cases_name"], version=data["version"], models=data["models"],url=data["RequestAddress"],
                    data = data["RequestData"],sql = data["RequestSql"],code = data["code"],actually = '',
                    sql_result = '',result = '',msg = '',user_id=session["admin"],method=data["RequestMethod"],
                    case_leader=data["case_leader"], comment=data["comment"], Environment=data["Environment"],
                    pass_num='', fail_num='', execute_count='', case_pass='', status=0)
        db.session.add(case)
        db.session.commit()
        flash("添加用例成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加用例：%s" % data['cases_name'])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/case_add.html", form=form)


# 用例状态
@admin.route("/case/status/<int:id>/<int:status>", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def case_status(id=None, status=None):
    case = Case.query.get_or_404(id)
    if status == 0:
        case.status = 1
        flash("停用项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="停用项目%s" % id)
        db.session.add(oplog)
        db.session.commit()
    else:
        case.status = 0
        flash("启用项目成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="启用项目%s" % id)
        db.session.add(oplog)
        db.session.commit()
    db.session.add(case)
    db.session.commit()
    return redirect(url_for("admin.case_list", page=1))


# 用例删除
@admin.route("/case/del/<int:id>/<int:status>", methods=["GET"])
@admin_login_req
# @admin_auth
def case_del(id=None, status=None):
    case = Case.query.get_or_404(int(id))
    if status == 0:
        flash('项目正在使用！', category='err')
        return redirect(url_for('admin.case_list', page=1))
    db.session.delete(case)
    db.session.commit()
    flash("删除项目成功！", "ok")
    return redirect(url_for("admin.case_list", page=1))


# 环境列表
@admin.route("/environment/list/<int:page>/", methods=['GET'])
@admin_login_req
# @admin_auth
def environment_list(page=None):
    if page is None:
        page = 1
    page_data = Environment.query.order_by(
        Environment.addtime.desc()).paginate(
        page=page, per_page=10)
    return render_template("admin/environment_list.html", page_data=page_data)


# 添加环境
@admin.route("/environment/add/", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def environment_add():
    form = EnvironmentFrom()
    if form.validate_on_submit():
        data = form.data
        smtp = str({'mail_host': data["mail_host"], 'mail_user': data["mail_user"], 'mail_pass': data["mail_pass"],
                    'From': data["FromUser"], 'To': data["ToUser"], 'subject': data["subject"],
                    'MIMEText': data["MIMEText"]})
        if Environment.query.filter_by(name=data['name']).count() == 1:
            flash('环境名称已存在！', category='err')
            return redirect(url_for('admin.environment_add'))
        environment = Environment(name=data["name"], version=data["version"], project_url=data["project_url"],
                                  smtp=smtp, dbconfig=data["dbconfig"],
                                  user_id=session["admin"], comment=data["comment"], status=0)
        db.session.add(environment)
        db.session.commit()
        flash("添加环境成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="添加环境：%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
    return render_template("admin/environment_add.html", form=form)


# 环境修改
@admin.route("/environment/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def environment_edit(id=None):
    form = EnvironmentFrom()
    environment = Environment.query.get_or_404(id)
    if form.validate_on_submit():
        data = form.data
        smtp = str({'mail_host': data["mail_host"], 'mail_user': data["mail_user"], 'mail_pass': data["mail_pass"],
                    'From': data["FromUser"], 'To': data["ToUser"], 'subject': data["subject"],
                    'MIMEText': data["MIMEText"]})
        if Environment.query.filter_by(name=data['name']).count() == 1:
            flash('环境名称已存在！', category='err')
            return redirect(url_for('admin.project_edit'))
        environment.version = data['version']
        environment.name = data["name"]
        environment.project_url = data["project_url"]
        environment.dbconfig = data["dbconfig"]
        environment.smtp = smtp
        environment.comment = data["comment"]
        db.session.add(environment)
        db.session.commit()
        flash("修改环境配置成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="修改环境配置%s" % data['name'])
        db.session.add(oplog)
        db.session.commit()
        return render_template("admin/environment_edit.html", form=form, environment=environment)
    return render_template("admin/environment_edit.html", form=form, environment=environment)


# 环境状态
@admin.route("/environment/status/<int:id>/<int:status>", methods=["GET", "POST"])
@admin_login_req
# @admin_auth
def environment_status(id=None, status=None):
    environment = Environment.query.get_or_404(id)
    if status == 0:
        environment.status = 1
        flash("停用环境成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="停用环境%s" % id)
        db.session.add(oplog)
        db.session.commit()
    else:
        environment.status = 0
        flash("启用环境成功！", "ok")
        oplog = Oplog(admin_id=session["admin_id"], ip=request.remote_addr, reason="启用环境%s" % id)
        db.session.add(oplog)
        db.session.commit()
    db.session.add(environment)
    db.session.commit()
    return redirect(url_for("admin.environment_list", page=1))


# 环境删除
@admin.route("/environment/del/<int:id>/<int:status>", methods=["GET"])
@admin_login_req
# @admin_auth
def environment_del(id=None, status=None):
    environment = Environment.query.get_or_404(int(id))
    if status == 0:
        flash('环境正在使用！', category='err')
        return redirect(url_for('admin.environment_list', page=1))
    db.session.delete(environment)
    db.session.commit()
    flash("删除环境成功！", "ok")
    return redirect(url_for("admin.environment_list", page=1))
