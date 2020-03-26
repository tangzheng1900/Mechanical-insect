import datetime
from app import db


from datetime import datetime
from app import db

# 定义项目管理模型
class Project(db.Model):
    __tablename__ = "project"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 项目名称
    version = db.Column(db.String(100), unique=True)  # 项目版本
    models = db.Column(db.String(100))  # 项目模块
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属会员
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 创建时间
    case_num = db.Column(db.Integer)  # 用例数量
    execute_count = db.Column(db.Integer)  # 执行次数
    case_pass = db.Column(db.Integer)  # 用例通过率
    status = db.Column(db.Integer)  # 项目状态
    comment = db.Column(db.Text)  # 备注

    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Project %r>" % self.name


# 用例管理
class Case(db.Model):
    __tablename__ = "testcase"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    version = db.Column(db.String(100), unique=True)  # 版本
    models = db.Column(db.String(100))  # 模块
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属会员
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 创建时间
    uptime = db.Column(db.DateTime, index=True)  # 更新时间
    Environment = db.Column(db.String(100))  # 运行环境
    pass_num = db.Column(db.Integer)  # 通过数量
    fail_num = db.Column(db.Integer)  # 失败数量
    execute_count = db.Column(db.Integer)  # 执行次数
    case_pass = db.Column(db.Integer)  # 用例通过率
    status = db.Column(db.Integer)  # 用例状态
    comment = db.Column(db.Text)  # 备注

    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<Case %r>" % self.name


# 定义会员数据模型
class User(db.Model):
    __tablename__ = "user"  # 存入表名称
    __table_args__ = {"useexisting": True}
    # column字段  unique唯一
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 昵称
    pwd = db.Column(db.String(100))  # 密码
    email = db.Column(db.String(100), unique=True)  # 邮箱
    phone = db.Column(db.String(11), unique=True)  # 手机号码
    info = db.Column(db.Text)  # 个性简介
    face = db.Column(db.String(255), unique=True)  # 头像
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)#注册时间，now是本地时间，可以认为是你电脑现在的时间，utcnow是世界时间（时区不同，所以这两个是不一样的）
    uuid = db.Column(db.String(255), unique=True)  # 唯一标识符
    userlogs = db.relationship('Userlog', backref='user')  # 会员日志外键关系
    comments = db.relationship('Comment', backref='user')  # 评论外键关系
    moviecols = db.relationship('Moviecol', backref='user')  # 收藏外键关系


    # 定义一个方法，返回的类型
    def __repr__(self):
        return "<User %r>" % self.name

    def check_pwd(self,pwd):
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd,pwd)




# 会员登录日志
class Userlog(db.Model):
    __tablename__ = "userlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 db.ForeignKey
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属会员
    ip = db.Column(db.String(100))  # 登录IP
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Userlog %r>" % self.id


# 定义标签
class Tag(db.Model):
    __tablename__ = "tag"  # 定义表名称
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间
    movies = db.relationship("Movie", backref='tag')  # 电影外键关系关联

    # 返回类型
    def __repr__(self):
        return "<Tag %r>" % self.name


# 电影
class Movie(db.Model):
    __tablename__ = "movie"  # 定义表名称
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    title = db.Column(db.String(255), unique=True)  # 标题
    url = db.Column(db.String(255), unique=True)  # 地址
    info = db.Column(db.Text)  # 简介
    logo = db.Column(db.String(255), unique=True)  # 封面
    star = db.Column(db.SmallInteger)  # 星级  小整形
    playnum = db.Column(db.BigInteger)  # 播放量
    commentnum = db.Column(db.BigInteger)  # 评论量
    tag_id = db.Column(db.Integer, db.ForeignKey('tag.id'))  # 所属标签
    area = db.Column(db.String(255))  # 上映地区
    release_time = db.Column(db.Date)  # 上映时间
    length = db.Column(db.String(100))  # 播放时间
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间
    comments = db.relationship("Comment", backref='movie')  # 评论外键关系关联
    moviecols = db.relationship("Moviecol", backref='movie')  # 收藏外键关系关联

    def __repr__(self):
        return "<Movie %r>" % self.title


# 上映预告
class Preview(db.Model):
    __tablename__ = "preview"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    title = db.Column(db.String(255), unique=True)  # 标题
    logo = db.Column(db.String(255), unique=True)  # 封面
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Preview %r>" % self.title


# 评论
class Comment(db.Model):
    __tablename__ = "comment"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    content = db.Column(db.Text)  # 内容
    movie_id = db.Column(db.Integer, db.ForeignKey('movie.id'))  # 所属电影
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属用户
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Comment %r>" % self.id


# 电影收藏
class Moviecol(db.Model):
    __tablename__ = "moviecol"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    movie_id = db.Column(db.Integer, db.ForeignKey('movie.id'))  # 所属电影
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属用户
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Moviecol %r>" % self.id


# 权限
class Auth(db.Model):
    __tablename__ = "auth"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    url = db.Column(db.String(255), unique=True)  # 地址
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间

    def __repr__(self):
        return "<Auth %r>" % self.name


# 角色
class Role(db.Model):
    __tablename__ = "role"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100), unique=True)  # 名称
    auths = db.Column(db.String(600))
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间
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
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'))  # 所属角色
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 添加时间
    adminlogs = db.relationship("Adminlog", backref='admin')  # 管理员登录日志外键关系关联
    oplogs = db.relationship("Oplog", backref='admin')  # 管理员操作日志外键关系关联

    def __repr__(self):
        return "<Role %r>" % self.name

    def check_pwd(self,pwd):
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd,pwd)


# 管理员登录日志
class Adminlog(db.Model):
    __tablename__ = "adminlog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 db.ForeignKey
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 登录IP
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Adminlog %r>" % self.id


# 操作日志
class Oplog(db.Model):
    __tablename__ = "oplog"  # 定义表名
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    # 定义外键 db.ForeignKey
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 登录IP
    reason = db.Column(db.String(600))  # 操作原因
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 登录时间 ，默认时间

    def __repr__(self):
        return "<Oplog %r>" % self.id

if __name__ == '__main__':
    # 创建数据表
    print(db)
    db.create_all()
    print('创建表')

    # 添加角色
    role = Role(
        name="超级管理员",
        auths="",
    )
    db.session.add(role)
    db.session.commit()

    # 添加管理员
    from werkzeug.security import generate_password_hash

    admin = Admin(
        name='admin',
        pwd=generate_password_hash('123456'),  # 加密密码
        is_super=0,
        role_id=1,
    )
    db.session.add(admin)
    db.session.commit()