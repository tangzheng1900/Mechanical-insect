# -*- coding: utf-8 -*-
# @Time    : 2019/12/9 10:46
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : models.py
# @Software: PyCharm
'''
类型
类型名	Python类型	说 明
Integer	int	普通整数，一般是32位(常用)
SmallInteger	int	取值范围小的整数，一般是16位
BigInteger	int或long	不限制精度的整数
Float	float	浮点数
Numeric	decimal.Decimal	定点数
String	str	变长字符串(常用)
Text	str	变长字符串，对较长或不限长度的字符串做了优化(常用)
Unicode	unicode	变长Unicode字符串
UnicodeText	Unicode	变长Unicode字符串，对较长或不限长度的字符串做了优化
Boolean	bool	布尔值
Date	datetime.date	日期
Time	datetime.time	时间
DateTime	datetime.datetime	日期和时间(常用)
Interval	datetime.timedelta	时间间隔
Enum	str	一组字符串
PickleType	任何Python对象	自动使用pickle序列化
LargeBinary	str	二进制文件
————————————————
选项
选项名	说明
primary_key	如果设为True，这列就是表的主键
unique	如果设为True，这列不允许出现重复的值
index	如果设为True，为这列创建索引，提升查询效率
nullable	如果设为True，这列允许使用空值，如果设为False，这列不允许使用空值
default	为这列设定默认值
————————————————
定义关系类型常用
选项名	说明
backref	在关系的另一个模型中添加反向引用
primaryjoin	明确指定两个模型之间使用的联结条件，只在模棱两可的关系中需要指定
lazy	指定如何加载相关记录，可选值有select（首次访问时按需加载）、immediate（源对象加载后就加载）、joined（加载记录，但使用联结）、subquery（立即加载，但使用子查询）、noload（永不加载）和dynamic（不加载记录，但提供加载记录的查询）
uselist	如果设为False，不使用列表，而使用标量值
order_by	指定关系中记录的排序方式
secondary	指定多对多关系中关系表的名字
secondaryjoin	SQLAlchemy无法自行决定时，指定多对多关系中的二级联结条件
————————————————
'''

# from sqlalchemy.orm import relationship, backref
# from sqlalchemy import Column,Integer,String,DateTime,Enum,ForeignKey,SmallInteger,Text,UniqueConstraint,ForeignKeyConstraint,Index
# from app import Base
from app import db
from datetime import datetime


class User(db.Model):
    __tablename__ = 'users'
    __table_args__ = {"useexisting": True}
    # column字段  unique唯一
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 昵称
    pwd = db.Column(db.String(100))  # 密码
    email = db.Column(db.String(100), unique=True)  # 邮箱
    phone = db.Column(db.String(11), unique=True)  # 手机号码
    info = db.Column(db.Text)  # 个性简介
    face =db.Column(db.String(255), unique=True)  # 头像
    addtime = db.Column(db.DateTime(), default=datetime.now)  # 注册时间，now是本地时间，可以认为是你电脑现在的时间，utcnow是世界时间（时区不同，所以这两个是不一样的）
    uuid = db.Column(db.String(255), unique=True)  # 唯一标识符

    userlogs = db.relationship('Userlog', backref='users')  # 会员日志外键关系
    projects = db.relationship('Project', backref='users')  # 会员外键关系
    # projects2 = db.relationship('Project', backref='users2')  # 负责人外键关系
    cases = db.relationship('Case', backref='users')  # 用例人外键关系
    environments = db.relationship('Environment', backref='users')  # 环境外键关系
    # cases2 = db.relationship('Case', backref='users2')  # 接口人外键关系

    def __init__(self, name=None, email=None):
        self.name = name
        self.email = email


    def __repr__(self):
        return '<User %r>' % (self.name)

# 定义项目管理模型
class Project(db.Model):
    __tablename__ = "project"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 项目名称
    version = db.Column(db.String(100), unique=True)  # 项目版本
    models = db.Column(db.String(100))  # 项目模块
    user_id = db.Column(db.String(100))  # 所属用户
    leader = db.Column(db.Integer, db.ForeignKey('users.id'))  # 项目负责人
    addtime = db.Column(db.DateTime, default=datetime.now)  # 创建时间
    case_num = db.Column(db.Integer)  # 用例数量
    execute_count = db.Column(db.Integer)  # 执行次数
    case_pass = db.Column(db.Float)  # 用例通过率
    status = db.Column(db.Integer)  # 项目状态
    comment = db.Column(db.Text)  # 备注

    # user = db.relationship('User', foreign_keys=user_id)
    # leader = db.relationship('User', foreign_keys=leader)
    #
    # def __init__(self, user_id, leader):
    #     self.user_id = user_id
    #     self.leader = leader


    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Project %r>" % self.name

# 用例管理
class Case(db.Model):
    __tablename__ = "case"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    cases_name = db.Column(db.String(100), unique=True)  # 名称
    method = db.Column(db.String(100))  # 请求方法
    url = db.Column(db.String(1000))  # 接口路径
    data = db.Column(db.String(5000))  # 请求参数
    sql = db.Column(db.String(1000))  # 请求sql参数
    code = db.Column(db.String(100))  # 期望值
    actually = db.Column(db.String(100))  # 实际返回
    sql_result = db.Column(db.String(100))  # 数据库返回
    result = db.Column(db.String(5000))  # 测试结果
    msg = db.Column(db.String(100))  # 返回信息
    version = db.Column(db.String(100), unique=True)  # 版本
    models = db.Column(db.String(100))  # 模块
    user_id = db.Column(db.String(100))  # 所属用户
    case_leader = db.Column(db.Integer, db.ForeignKey('users.id'))  # 接口负责人
    addtime = db.Column(db.DateTime,default=datetime.now)  # 创建时间
    update_time = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)  # 更新时间
    Environment = db.Column(db.String(100))  # 运行环境
    pass_num = db.Column(db.Integer)  # 通过数量
    fail_num = db.Column(db.Integer)  # 失败数量
    execute_count = db.Column(db.Integer)  # 执行次数
    case_pass = db.Column(db.Float)  # 用例通过率
    status = db.Column(db.Integer)  # 用例状态
    comment = db.Column(db.Text)  # 备注

    # user = db.relationship('User', foreign_keys=user_id)
    # leader = db.relationship('User', foreign_keys=leader_id)

    # def __init__(self, user_id, leader):
    #     self.user_id = user_id
    #     self.leader = leader

    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Case %r>" % self.name


# 定义项目环境配置
class Environment(db.Model):
    __tablename__ = "environment"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 项目名称
    version = db.Column(db.String(100), unique=True)  # 项目版本
    smtp = db.Column(db.String(1000))  # 邮件配置
    project_url = db.Column(db.String(1000))  # 项目地址
    dbconfig = db.Column(db.String(1000))  # 项目数据库
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))  # 所属用户
    addtime = db.Column(db.DateTime, default=datetime.now)  # 创建时间
    status = db.Column(db.Integer)  # 状态
    comment = db.Column(db.Text)  # 备注

    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Project %r>" % self.name


# 会员登录日志
class Userlog(db.Model):
    __tablename__ = "userlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 db.ForeignKey
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'))  # 所属会员
    ip = db.Column(db.String(100))  # 登录IP
    addtime = db.Column(db.DateTime, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Userlog %r>" % self.id

# 权限
class Auth(db.Model):
    __tablename__ = "auth"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    url = db.Column(db.String(255), unique=True)  # 地址
    addtime = db.Column(db.DateTime, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Auth %r>" % self.name

# 角色
class Role(db.Model):
    __tablename__ = "role"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    auths = db.Column(db.String(600))
    addtime = db.Column(db.DateTime,  default=datetime.now)  # 添加时间
    roles = db.relationship("Admin", backref='role')

    def __repr__(self):
        return "<Role %r>" % self.name

# 管理员
class Admin(db.Model):
    __tablename__ = "admin"  # 存入表名称
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 管理员账号
    pwd = db.Column(db.String(100))  # 管理员密码
    is_super = db.Column(db.SmallInteger)  # 是否为超级管理员，0为超级管理员
    role_id = db.Column(db.Integer,db.ForeignKey('role.id'))  # 所属角色
    addtime = db.Column(db.DateTime,  default=datetime.now)  # 添加时间
    adminlogs = db.relationship("Adminlog", backref='admin')  # 管理员登录日志外键关系关联
    oplogs = db.relationship("Oplog", backref='admin')  # 管理员操作日志外键关系关联
    state = db.Column(db.SmallInteger)  # 是否为启用，0为启用

    def __repr__(self):
        return "<Role %r>" % self.name

    def check_pwd(self, pwd):
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd, pwd)

# 管理员登录日志
class Adminlog(db.Model):
    __tablename__ = "adminlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 ForeignKey
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 登录IP
    addtime = db.Column(db.DateTime,  default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Adminlog %r>" % self.id


# 操作日志
class Oplog(db.Model):
    __tablename__ = "oplog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 ForeignKey
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 登录IP
    reason = db.Column(db.String(600))  # 操作原因
    addtime = db.Column(db.DateTime, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Oplog %r>" % self.id
        

if __name__ == '__main__':
    # from app import init_db,db_session

    db.create_all()
    print('创建表')
    # init_db()

    # # 添加角色
    # role = Role(
    #     name="超级管理员",
    #     auths="",
    # )
    # db.session.add(role)
    # db.session.commit()
    #
    # # 添加管理员
    # from werkzeug.security import generate_password_hash
    #
    # admin = Admin(
    #     name='admin',
    #     pwd=generate_password_hash('123456'),  # 加密密码
    #     is_super=0,
    #     role_id=1,
    # )
    # db.session.add(admin)
    # db.session.commit()

