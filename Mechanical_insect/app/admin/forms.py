# -*- coding: utf-8 -*-
# @Time    : 2019/12/9 10:38
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : forms.py
# @Software: PyCharm

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField,FileField,TextAreaField,SelectField,SelectMultipleField
from wtforms.validators import DataRequired,ValidationError,EqualTo
from app.models import Admin, Auth,Role

class LoginForm(FlaskForm):
    '''管理员登录'''
    account = StringField(
        label="账号",
        validators=[
            DataRequired("Name Error")
        ],
        description="账号",
        render_kw={
            "class": "form-control",
            "placeholder": "username",
            # "required": "required"
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("Pwd Error")
        ],
        description="密码",
        render_kw={
            "class": "form-control",
            "placeholder": "password",
            # "required": "required"
        }
    )
    submit = SubmitField(
        '登 录',
        render_kw={
            "class": "btn btn-primary btn-block btn-flat",
        }
    )

    def validate_account(self, field):
        account = field.data
        admin = Admin.query.filter_by(name=account).count()
        if admin == 0:
            raise ValidationError("Name Undefined")