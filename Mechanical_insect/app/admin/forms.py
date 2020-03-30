# -*- coding: utf-8 -*-
# @Time    : 2019/12/9 10:38
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : forms.py
# @Software: PyCharm

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, ValidationError, EqualTo
from app.models import Admin, Auth, Role, User, Project, Environment, Case

project_list = Project.query.all()
auths_list = Auth.query.all()
role_list = Role.query.all()
user_list = User.query.all()
environment_list = Environment.query.all()
testcase_list = Case.query.with_entities(Case.method).distinct().all()


class LoginForm(FlaskForm):
    '''管理员登录'''
    account = StringField(
        label="用户名",
        validators=[
            DataRequired("用户名错误")
        ],
        description="用户名",
        render_kw={
            "class": "form-control",
            "placeholder": "用户名",
            "lay-verify": "required",
            "type": "text"
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("密码错误")
        ],
        description="密码",
        render_kw={
            "class": "form-control",
            "placeholder": "密码",
            "lay-verify": "required",
            "type": "password"
        }
    )
    submit = SubmitField(
        '登 录',
        render_kw={
            "class": "btn btn-primary btn-block btn-flat",
            "lay - submit lay - filter": "login",
            "style": "width:100%;",
            "type": "submit"
        }
    )

    def validate_account(self, field):
        account = field.data
        admin = Admin.query.filter_by(name=account).count()
        if admin == 0:
            raise ValidationError("无效用户名")


class AdminForm(FlaskForm):
    name = StringField(
        label="管理员名称",
        validators=[DataRequired("请输入管理员名称")],
        description="管理员名称",
        render_kw={"class": "form-control", "placeholder": "请输入管理员名称"}
    )
    pwd = PasswordField(
        label="密码",
        validators=[DataRequired("请输入密码")],
        description="密码",
        render_kw={"class": "form-control", "placeholder": "请输入密码", }
    )
    repwd = PasswordField(
        label="重复管理员密码",
        validators=[
            DataRequired("请输入重复密码"),
            EqualTo('pwd', message="两次密码不一致")
        ],
        description="管理员密码重复",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入密码",
        }
    )
    role_id = SelectField(
        label="所属角色",
        coerce=int,
        choices=[(v.id, v.name) for v in role_list],
        render_kw={
            "class": "form-control",
        }

    )
    submit = SubmitField(
        '确认',
        render_kw={"class": "btn btn-outline-info btn-sm", }
    )
    edit = SubmitField(
        '编辑',
        render_kw={"class": "btn btn-outline-info btn-sm"}
    )


# 角色
class RoleForm(FlaskForm):
    name = StringField(
        label="角色名称",
        validators=[
            DataRequired("请输入角色名称")
        ],
        description="角色名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入角色名称"
        }
    )
    auths = SelectMultipleField(
        label="权限列表",
        validators=[
            DataRequired("请输入权限列表")
        ],
        coerce=int,
        choices=[(v.id, v.name) for v in auths_list],
        description="权限列表",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限列表"
        }
    )
    submit = SubmitField(
        '确认',
        render_kw={
            "class": "btn btn-outline-info btn-sm"
        }
    )
    edit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-outline-info btn-sm"
        }
    )


# 权限
class AuthFrom(FlaskForm):
    name = StringField(
        label="权限名称",
        validators=[
            DataRequired("请输入权限名称")
        ],
        description="权限名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限名称"
        }
    )
    url = StringField(
        label="权限地址",
        validators=[
            DataRequired("请输入权限地址")
        ],
        description="权限地址",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限地址"
        }
    )
    submit = SubmitField(
        '确认',
        render_kw={
            "class": "btn btn-outline-info btn-sm"
        }
    )
    edit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-outline-info btn-sm"
        }
    )


# 项目
class ProjectFrom(FlaskForm):
    name = StringField(
        label="项目名称",
        validators=[
            DataRequired("请输入项目名称")
        ],
        description="项目名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入项目名称"
        }
    )
    version = StringField(
        label="版本编号",
        validators=[
            DataRequired("请输入版本编号")
        ],
        description="版本编号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入版本编号"
        }
    )
    models = StringField(
        label="模块",
        validators=[
            DataRequired("请输入模块名称")
        ],
        description="模块",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入模块名称"
        }
    )

    leader = SelectMultipleField(
        label="负责人列表",
        validators=[
            DataRequired("请选择负责人")
        ],
        coerce=int,
        choices=[(v.id, v.name) for v in user_list],
        description="负责人列表",
        render_kw={
            "class": "form-control",
            "placeholder": "请选择负责人"
        }
    )

    comment = StringField(
        label="备注",
        validators=[
            DataRequired("备注")
        ],
        description="备注",
        render_kw={
            "class": "form-control",
            "placeholder": "备注"
        }
    )

    submit = SubmitField(
        '确定',
        render_kw={
            "class": "btn btn-outline-info btn-sm"
        }
    )


# 用例
class CaseFrom(FlaskForm):
    cases_name = StringField(
        label="用例名称",
        validators=[
            DataRequired("请输入用例名称")
        ],
        description="用例名称",
        render_kw={
            "placeholder": "请输入用例名称",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )
    version = SelectMultipleField(
        label="版本编号",
        validators=[
            DataRequired("请输入版本编号")
        ],
        coerce=str,
        choices=[(v.version, v.version) for v in project_list],
        description="版本编号",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请输入版本编号"
        }
    )
    models = SelectMultipleField(
        label="项目模块",
        validators=[
            DataRequired("请选择项目模块")
        ],
        coerce=str,
        choices=[(v.name, v.name) for v in project_list],
        description="项目模块",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请选择项目模块"
        }
    )

    case_leader = SelectMultipleField(
        label="负责人列表",
        validators=[
            DataRequired("请选择负责人！")
        ],
        coerce=int,
        choices=[(v.id, v.name) for v in user_list],
        description="负责人列表",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请选择负责人"
        }
    )

    Environment = SelectMultipleField(
        label="环境列表",
        validators=[
            DataRequired("请选执行环境")
        ],
        coerce=str,
        choices=[(v.name, v.name) for v in environment_list],
        description="环境列表",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请选执行环境！"
        }
    )

    RequestAddress = StringField(
        label="接口路径",
        validators=[
            DataRequired("请输入接口路径")
        ],
        description="接口路径",
        render_kw={
            "placeholder": "请输入接口路径",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    code = StringField(
        label="预期返回",
        validators=[
            DataRequired("请输入预期返回code值")
        ],
        description="预期返回",
        render_kw={
            "placeholder": "请输入预期返回code值",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    RequestMethod = SelectMultipleField(
        label="请求方法",
        validators=[
            DataRequired("请选请求方法")
        ],
        coerce=str,
        choices=[(v.method, v.method) for v in testcase_list],
        description="请求方法",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请选请求方法"
        }
    )

    RequestData = TextAreaField(
        label="请求参数",
        validators=[
            DataRequired("请输入json参数")
        ],
        description="请输入json参数",
        render_kw={
            "class": "layui-textarea",
            "placeholder": "请输入json参数"
        }
    )

    RequestSql= StringField(
        label="SQL请求",
        validators=[
            DataRequired("请输入对应数据库调用json")
        ],
        description="SQL请求",
        render_kw={
            "placeholder": "若无需查询使用：{}",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    comment = TextAreaField(
        label="备注",
        validators=[
            DataRequired("请输入内容")
        ],
        description="请输入内容",
        render_kw={
            "class": "layui-textarea",
            "placeholder": "请输入内容"
        }
    )

    submit = SubmitField(
        '立即提交',
        render_kw={
            "class":"layui-btn",
            "lay-submit":"",
            "lay-filter":"component-form-demo1"
        }
    )


# 环境
class EnvironmentFrom(FlaskForm):
    name = StringField(
        label="环境名称",
        validators=[
            DataRequired("请输入环境名称")
        ],
        description="环境名称",
        render_kw={
            "placeholder": "请输入环境名称",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )
    version = SelectMultipleField(
        label="版本编号",
        validators=[
            DataRequired("请输入版本编号")
        ],
        coerce=int,
        choices=[(v.id, v.version) for v in project_list],
        description="版本编号",
        render_kw={
            "class": "layui-input-inline",
            "placeholder": "请输入版本编号"
        }
    )

    project_url = StringField(
        label="环境地址",
        validators=[
            DataRequired("请输入环境地址")
        ],
        description="环境地址",
        render_kw={
            "placeholder": "请输入环境地址",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    mail_host = StringField(
        label="SMTP",
        validators=[
            DataRequired("请输入SMTP服务器,如：smtp.163.com")
        ],
        description="SMTP服务器",
        render_kw={
            "placeholder": "请输入SMTP服务器",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    mail_user = StringField(
        label="邮箱用户",
        validators=[
            DataRequired("请输入邮箱用户")
        ],
        description="邮箱用户",
        render_kw={
            "placeholder": "请输入邮箱用户",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    mail_pass = StringField(
        label="邮箱密码",
        validators=[
            DataRequired("请输入邮箱密码")
        ],
        description="邮箱密码",
        render_kw={
            "placeholder": "请输入邮箱密码",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    FromUser = StringField(
        label="发送人",
        validators=[
            DataRequired("请输入发送人")
        ],
        description="发送人",
        render_kw={
            "placeholder": "请输入发送人",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    ToUser = StringField(
        label="接收人",
        validators=[
            DataRequired("请输入接收人")
        ],
        description="接收人",
        render_kw={
            "placeholder": "请输入接收人",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    subject = StringField(
        label="邮件标题",
        validators=[
            DataRequired("请输入邮件标题")
        ],
        description="邮件标题",
        render_kw={
            "placeholder": "请输入邮件标题",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    MIMEText = TextAreaField(
        label="邮件正文",
        validators=[
            DataRequired("请输入邮件正文")
        ],
        description="邮件正文",
        render_kw={
            "placeholder": "请输入邮件正文",
            "class": "layui-textarea"
        }
    )

    dbconfig = StringField(
        label="数据库参数",
        validators=[
            DataRequired("请输入对应数据库参数")
        ],
        description="数据库参数",
        render_kw={
            "placeholder": "请输入对应数据库参数",
            "type": "text",
            "lay - verify": "title",
            "autocomplete": "off",
            "class": "layui-input"
        }
    )

    comment = TextAreaField(
        label="备注",
        # validators=[
        #     DataRequired("请输入内容")
        # ],
        # description="请输入内容",
        render_kw={
            "class": "layui-textarea",
            "placeholder": "请输入内容"
        }
    )

    submit = SubmitField(
        '立即提交',
        render_kw={
            "class": "layui-btn",
            "lay-submit": "",
            "lay-filter": "component-form-demo1"
        }
    )
