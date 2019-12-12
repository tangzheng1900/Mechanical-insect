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

from sqlalchemy.orm import relationship, backref
from sqlalchemy import Column,Integer,String,DateTime,Enum,ForeignKey,SmallInteger,Text,UniqueConstraint,ForeignKeyConstraint,Index
from app import Base
from datetime import datetime


class User(Base):
    __tablename__ = 'users'
    __table_args__ = {"useexisting": True}
    # column字段  unique唯一
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 昵称
    pwd = Column(String(100))  # 密码
    email = Column(String(100), unique=True)  # 邮箱
    phone = Column(String(11), unique=True)  # 手机号码
    info = Column(Text)  # 个性简介
    face = Column(String(255), unique=True)  # 头像
    addtime = Column(DateTime(),
                        default=datetime.now)  # 注册时间，now是本地时间，可以认为是你电脑现在的时间，utcnow是世界时间（时区不同，所以这两个是不一样的）
    uuid = Column(String(255), unique=True)  # 唯一标识符

    userlogs = relationship('Userlog', backref='users')  # 会员日志外键关系
    projects = relationship('Project', backref='users')  # 会员外键关系
    projects2 = relationship('Project', backref='users2')  # 负责人外键关系
    cases = relationship('Case', backref='users')  # 用例人外键关系
    cases2 = relationship('Case', backref='users2')  # 接口人外键关系

    def __init__(self, name=None, email=None):
        self.name = name
        self.email = email


    def __repr__(self):
        return '<User %r>' % (self.name)

# 定义项目管理模型
class Project(Base):
    __tablename__ = "project"
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 项目名称
    version = Column(String(100), unique=True)  # 项目版本
    models = Column(String(100))  # 项目模块
    user_id = Column(Integer, ForeignKey('users.id'))  # 所属会员
    leader = Column(Integer, ForeignKey('users2.id'))   # 项目负责人
    addtime = Column(DateTime, default=datetime.now)  # 创建时间
    case_num = Column(Integer)  # 用例数量
    execute_count = Column(Integer)  # 执行次数
    case_pass = Column(Integer)  # 用例通过率
    status = Column(Integer)  # 项目状态
    comment = Column(Text)  # 备注




    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Project %r>" % self.name

# 用例管理
class Case(Base):
    __tablename__ = "case"
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 名称
    version = Column(String(100), unique=True)  # 版本
    models = Column(String(100))  # 模块
    user_id = Column(Integer, ForeignKey('users.id'))  # 所属会员
    case_leader = Column(Integer, ForeignKey('users2.id'))  # 接口负责人
    addtime = Column(DateTime,default=datetime.now)  # 创建时间
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now)  # 更新时间
    Environment = Column(String(100))  # 运行环境
    pass_num = Column(Integer)  # 通过数量
    fail_num = Column(Integer)  # 失败数量
    execute_count = Column(Integer)  # 执行次数
    case_pass = Column(Integer)  # 用例通过率
    status = Column(Integer)  # 用例状态
    comment = Column(Text)  # 备注


    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Case %r>" % self.name

# 会员登录日志
class Userlog(Base):
    __tablename__ = "userlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    # 定义外键 db.ForeignKey
    user_id = Column(Integer, ForeignKey('users.id'))  # 所属会员
    ip = Column(String(100))  # 登录IP
    addtime = Column(DateTime, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Userlog %r>" % self.id

# 权限
class Auth(Base):
    __tablename__ = "auth"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 名称
    url = Column(String(255), unique=True)  # 地址
    addtime = Column(DateTime, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Auth %r>" % self.name

# 角色
class Role(Base):
    __tablename__ = "role"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 名称
    auths = Column(String(600))
    addtime = Column(DateTime,  default=datetime.now)  # 添加时间
    roles = relationship("Admin", backref='role')

    def __repr__(self):
        return "<Role %r>" % self.name

# 管理员
class Admin(Base):
    __tablename__ = "admin"  # 存入表名称
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    name = Column(String(100), unique=True)  # 管理员账号
    pwd = Column(String(100))  # 管理员密码
    is_super = Column(SmallInteger)  # 是否为超级管理员，0为超级管理员
    role_id = Column(Integer, ForeignKey('role.id'))  # 所属角色
    addtime = Column(DateTime,  default=datetime.now)  # 添加时间
    adminlogs = relationship("Adminlog", backref='admin')  # 管理员登录日志外键关系关联
    oplogs = relationship("Oplog", backref='admin')  # 管理员操作日志外键关系关联

    def __repr__(self):
        return "<Role %r>" % self.name

    def check_pwd(self, pwd):
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd, pwd)

# 管理员登录日志
class Adminlog(Base):
    __tablename__ = "adminlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    # 定义外键 ForeignKey
    admin_id = Column(Integer, ForeignKey('admin.id'))  # 所属管理员
    ip = Column(String(100))  # 登录IP
    addtime = Column(DateTime,  default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Adminlog %r>" % self.id

# 操作日志
class Oplog(Base):
    __tablename__ = "oplog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = Column(Integer, primary_key=True)  # 编号
    # 定义外键 ForeignKey
    admin_id = Column(Integer, ForeignKey('admin.id'))  # 所属管理员
    ip = Column(String(100))  # 登录IP
    reason = Column(String(600))  # 操作原因
    addtime = Column(DateTime, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Oplog %r>" % self.id
        

if __name__ == '__main__':
    from app import init_db,db_session

    print('创建表')
    init_db()

    # # 添加角色
    # role = Role(
    #     name="超级管理员",
    #     auths="",
    # )
    # db_session.add(role)
    # db_session.commit()
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
    # db_session.add(admin)
    # db_session.commit()

