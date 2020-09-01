# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 16:44
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : init.py
# @Software: PyCharm

from flask import Flask, render_template
import os
from flask_sqlalchemy import SQLAlchemy
import interface_auto_cases.conf.NacosConfig as NC

db = NC.config
# 定义数据库连接
app = Flask(__name__)  # 创建实例化app对象
import logging

logger = logging.getLogger("werkzeug")
logger.setLevel(logging.INFO)

# app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:123456@192.168.182.130:3306/autotest"
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://" + db['user'] + ":" + db['password'] + "@" + db[
    'host'] + ":" + str(db['port']) + "/" + db['database']
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = True  # 配置，如果设置True,将会追踪对象修改并且发送信号
app.config['SQLALCHEMY_ECHO'] = False  # 调试输出数据库信息
app.config["SECRET_KEY"] = "7c9d7c8e53614affba09ddc9947e4329"
app.config["UP_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)),"static/uploads/")
app.config["FC_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)),"static/uploads/user/")
app.debug = True
db = SQLAlchemy(app)  # 定义db，传入app对象



from app.home import home as home_blueprint
# 导入前后端模块
from app.admin import admin as admin_blueprint

# 注册蓝图 (添加前后端模块，将蓝图中的url映射关系加载到项目中)
app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint, url_prefix="/admin")


# 404
@app.errorhandler(404)
def page_not_found(error):
    # app.logger.warning('页面不存在！')
    return render_template("ul/404.html"), 404

# 500
@app.errorhandler(500)
def page_not_found(error):
    # app.logger.warning('服务器无响应！')
    return render_template("ul/500.html"), 500