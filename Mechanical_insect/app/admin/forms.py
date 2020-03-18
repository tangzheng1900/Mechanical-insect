# -*- coding: utf-8 -*-
# @Time    : 2019/12/9 10:38
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : forms.py
# @Software: PyCharm

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, ValidationError, EqualTo
from app.models import Admin, Auth, Role, User

auths_list = Auth.query.all()
role_list = Role.query.all()
user_list = User.query.all()


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
        validators=[DataRequired("请输入管理员名称！")],
        description="管理员名称",
        render_kw={"class": "form-control", "placeholder": "请输入管理员名称！"}
    )
    pwd = PasswordField(
        label="密码",
        validators=[DataRequired("请输入密码！")],
        description="密码",
        render_kw={"class": "form-control", "placeholder": "请输入密码！", }
    )
    repwd = PasswordField(
        label="重复管理员密码",
        validators=[
            DataRequired("请输入重复密码！"),
            EqualTo('pwd', message="两次密码不一致！")
        ],
        description="管理员密码重复",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入密码！",
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
            DataRequired("请输入角色名称！")
        ],
        description="角色名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入角色名称！"
        }
    )
    auths = SelectMultipleField(
        label="权限列表",
        validators=[
            DataRequired("请输入权限列表！")
        ],
        coerce=int,
        choices=[(v.id, v.name) for v in auths_list],
        description="权限列表",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限列表！"
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
            DataRequired("请输入权限名称！")
        ],
        description="权限名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限名称！"
        }
    )
    url = StringField(
        label="权限地址",
        validators=[
            DataRequired("请输入权限地址！")
        ],
        description="权限地址",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限地址！"
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
            DataRequired("请输入项目名称！")
        ],
        description="项目名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入项目名称！"
        }
    )
    version = StringField(
        label="版本编号",
        validators=[
            DataRequired("请输入版本编号！")
        ],
        description="版本编号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入版本编号！"
        }
    )
    models = StringField(
        label="模块",
        validators=[
            DataRequired("请输入模块名称！")
        ],
        description="模块",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入模块名称！"
        }
    )

    leader = SelectMultipleField(
        label="负责人列表",
        validators=[
            DataRequired("请选择负责人！")
        ],
        coerce=int,
        choices=[(v.id, v.name) for v in user_list],
        description="负责人列表",
        render_kw={
            "class": "form-control",
            "placeholder": "请选择负责人！"
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
    name = StringField(
        label="用例名称",
        validators=[
            DataRequired("请输入用例名称！")
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
    version = StringField(
        label="版本编号",
        validators=[
            DataRequired("请输入版本编号！")
        ],
        description="版本编号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入版本编号！"
        }
    )
    models = StringField(
        label="模块",
        validators=[
            DataRequired("请输入模块名称！")
        ],
        description="模块",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入模块名称！"
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
            "placeholder": "请选择负责人！"
        }
    )

    Environment = StringField(
        label="环境列表",
        validators=[
            DataRequired("请选执行环境！")
        ],
        # coerce=int,
        # choices=[(v.id, v.name) for v in user_list],
        description="环境列表",
        render_kw={
            "class": "form-control",
            "placeholder": "请选执行环境！"
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
