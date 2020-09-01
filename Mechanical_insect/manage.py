# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 16:41
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : manage.py
# @Software: PyCharm

from app import app
import logging


print('* ━━━━━━神兽出没━━━━━━')
print('* 　　　┏┓　　　┏┓')
print('* 　　┏┛┻━━━┛┻┓')
print('* 　　┃　　　　　　　┃')
print('* 　　┃　　　━　　　┃')
print('* 　　┃　┳┛　┗┳　┃')
print('* 　　┃　　　　　　　┃')
print('* 　　┃　　　┻　　　┃')
print('* 　　┃　　　　　　　┃')
print('* 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting')
print('* 　　　　┃　　　┃    神兽保佑,代码无bug')
print('* 　　　　┃　　　┃')
print('* 　　　　┃　　　┗━━━┓')
print('* 　　　　┃　　　　　　　┣┓')
print('* 　　　　┃　　　　　　　┏┛')
print('* 　　　　┗┓┓┏━┳┓┏┛')
print('* 　　　　　┃┫┫　┃┫┫')
print('* 　　　　　┗┻┛　┗┻┛')
print('*')
print('* ━━━━━━感觉萌萌哒━━━━━━')

if __name__ == '__main__':
    # print(app.url_map)  # 查看路由映射
    app.debug = True
    # handler = logging.FileHandler('flask.log', encoding='UTF-8')
    # handler.setLevel(logging.DEBUG)
    # logging_format = logging.Formatter(
    #     '%(asctime)s 【%(levelname)s】 -- %(filename)s _%(funcName)s _%(lineno)s : %(message)s')
    # handler.setFormatter(logging_format)
    # app.logger.addHandler(handler)
    app.run(host='0.0.0.0', port=82)  # 启动web服务器
