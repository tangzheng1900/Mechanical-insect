# -*- coding: utf-8 -*-
# @Time    : 2019/12/6 16:41
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : manage.py
# @Software: PyCharm

from app import app

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
    print(app.url_map)  # 查看路由映射
    app.run(host='172.16.16.47', port=82)# 启动web服务器