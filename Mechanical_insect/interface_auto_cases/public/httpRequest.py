# -*- coding: utf-8 -*-
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : manage.py
# @Software: PyCharm

import requests
import json, time
import interface_auto_cases.conf.NacosConfig as NC
from interface_auto_cases.public.logger import Log

logger = Log('httpRequest', NC.log_path)


# 登录获取客服cookie
def get_login_cookie():
    url1 = "https://testznkf.citydo.com.cn/v1/staff/login"
    data1 = {"username": "emhhbmcwMDE=", "password": "MTIzNDU2", "forceFlag": "true"}
    session = requests.Session()
    request = requests.post(url1, data1).json()
    logger.info("客服登录请求返回：%s" % request)
    cookie_jar = session.post(url1, data1).cookies
    # print(cookie_jar)
    cookie = requests.utils.dict_from_cookiejar(cookie_jar)
    logger.info("客服返回cookie：%s" % cookie)
    return cookie


# 登录获取客户cookie
def get_login_khcookie():
    url1 = "https://testznkf.citydo.com.cn/v1/tenants/_1NTMWLA/sessions"
    data1 = {"windowId": "WIN00000001", "os": 'null', "device": 'null', "channel": "pc", "msg_signature": "",
             "timestamp": "", "nonce": "", "userinfo": "", "ip": "", "browserid": ""}
    session = requests.Session()
    cookie_jar = session.post(url1, json=data1).cookies
    # print(cookie_jar)
    cookie = requests.utils.dict_from_cookiejar(cookie_jar)
    logger.info("客户返回cookie：%s" % cookie)
    return cookie


# 退出登录
def get_logout(url, data, headers):
    # body格式
    request = requests.post(url, json=data, headers=headers).json()
    logger.info('调用退出请求成功%s' % request)
    return request


class httpRequest:
    def httpGet(self, url, method, data, sql):
        from interface_auto_cases.public.get_mysql_info import getMysqlInfo
        global request
        headers = {"Host": "47.110.131.231", "Connection": "keep-alive", "Origin": "http://47.110.131.231",
                   "X-TraceId": "c502d7c0-5c48-11ea-98c2-1b2105b568ad",
                   "Referer": "http://47.110.131.231/customerService/SystemManagement/Online", }
        header = {"Host": "47.110.131.231", "Connection": "keep-alive", "Origin": "http://47.110.131.231",
                  "X-TraceId": "b2486a20-a9d1-11e9-a2b4-5fa2b013c14c",
                  "Referer": "http://47.110.131.231/customerService/SystemManagement/Online", }
        oo = get_login_cookie()
        pp = get_login_khcookie()
        headers["Cookie"] = 's_authorization=' + oo["s_authorization"]
        header["Cookie"] = 'v_authorization=' + pp["v_authorization"]
        # headers["Content-Type"] = "application/json"
        logger.info("当前客服headers配置：%s" % headers)
        logger.info("当前客客户header配置：%s" % header)

        if method == 'GET':
            logger.info('现在开始进行get请求')
            request = requests.get(url, data, headers=headers).json()
        elif method == 'GET_kh':
            logger.info('现在开始进行GET_kh请求')
            if data['1'] == 1:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'],
                                                                    sql['code'])
                url1 = url % str(sql_result[sql['1']])
                logger.info('现在开始进行数据库请求获取：{},当前请求地址：{}'.format(sql_result, url1))
                request = requests.get(url1, data, headers=header).json()
            elif data['1'] == 2:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'],
                                                                    sql['code'])
                url1 = url % str(sql_result[sql['1']])
                logger.info('现在开始进行数据库请求获取：{},当前请求地址：{}'.format(sql_result, url1))
                request = requests.get(url1, data, headers=headers).json()
            elif data['1'] == 0:
                # print(header)
                request = requests.get(url, headers=header).json()
            else:
                request = requests.get(url, data, headers=headers).json()


        elif method == 'POST_kh':
            logger.info('现在开始进行POST_kh请求')
            data['from'] = pp["visitor_id"]
            print(data)
            # body格式
            request = requests.post(url, json=data, headers=header).json()
            request['code'] = request['data']['message']

        elif method == 'POST':
            logger.info('现在开始进行post请求')
            # body格式
            request = requests.post(url, json=data, headers=headers).json()

        elif method == 'POST_file':
            logger.info('现在开始进行post_file请求')
            path = Allpath.project_path + "/request_file/" + sql['filename']
            print(sql['name'], headers, path)
            files = {sql['name']: (sql['filename'], open(path, 'rb'))}
            # body格式
            request = requests.post(url, data=data, files=files, headers=headers).json()

        elif method == 'POST1':
            logger.info('现在开始进行post1请求')
            # 参数格式
            request = requests.post(url, data, headers=headers).json()
            print(headers)

        elif method == 'POST2':
            logger.info('现在开始进行post2请求')
            # 参数格式
            request = requests.post(url, headers).json()

        elif method == 'POST_word':
            logger.info('现在开始进行post_word请求')
            request = {}
            # 参数格式,返回的是字符串格式
            text = requests.post(url, data, headers).text
            request['code'] = text

        elif method == 'POST_del':
            logger.info('现在开始进行post_del请求')
            sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'], sql['condition'],
                                                                sql['code'])
            logger.info('post删除数据库返回：' + str(sql_result))
            data['id'] = sql_result[0]
            # body格式
            request = requests.post(url, json=data, headers=headers).json()


        elif method == 'PUT':
            # 0:上下线单独处理；1：正常put；2：质检规则关闭处理；3、获取多个字段值json格式；4、获取多个字段值参数格式
            logger.info('现在开始进行put请求')
            headers["Content-Type"] = "application/json"
            # 2019年7月23日 16:17:38新增cookie不变循环处理方法
            if sql['1'] == 0:
                request1 = requests.put(
                    'http://47.110.131.231/v1/tenants/_1NTMWLA/staffs/s_819aee8ed8554b9f82e8d6302c8d2411/online',
                    data='{"status":"online"}', headers=headers).json()
                # print(request1)
                if 'test' in request1['data']:
                    oo["o_authorization"] = request1['data']['test']
                    # print(oo)
                # 新增cookie中o_authorization状态保存
                headers["Cookie"] = 's_authorization=' + oo["s_authorization"] + ';o_authorization=' + oo[
                    "o_authorization"]
                request = requests.put(url, data=json.dumps(data), headers=headers).json()
                time.sleep(0.3)
                # 退出
                get_logout('http://47.110.131.231/v1/tenants/_1NTMWLA/logout', '', headers)
            elif sql['1'] == 2:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'], sql['condition'], sql['code'])
                for i in range(len(sql_result)):
                    url_d = url + str(sql_result[i]["rule_id"])
                    request = requests.put(url_d, headers=headers).json()
                    logger.info("规则ID:%s关闭处理成功!" % sql_result[i]["rule_id"])
                logger.info(sql['condition'] + "关闭处理成功!")
            elif sql['1'] == 3:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'], sql['condition'], sql['code'])
                logger.info("再分配结果ID获取成功!{}".format(sql_result))
                url_d = url.format(sql_result[0], sql_result[3])
                print(url_d)
                request = requests.put(url_d, json=data, headers=headers).json()
            elif sql['1'] == 4:
                headers.pop('Content-Type')
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'], sql['condition'], sql['code'])
                logger.info("再分配结果ID获取成功!{}".format(sql_result))
                url_d = url.format(sql_result[0], sql_result[3])
                print(url_d)
                request = requests.put(url_d, data, headers=headers).json()
            else:
                # print(data)
                # .encode("UTF-8")对字符串进行`UTF-8`编码格式编码
                # 用dumps转义成json格式
                # json.dump()函数的使用，将json信息写进文件
                # json.dumps()   编码：把一个Python对象编码转换成Json字符串
                # json.load()函数的使用，将读取json信息
                # json.loads()  解码：把Json格式字符串解码转换成Python对象
                # body格式
                request = requests.put(url, data=json.dumps(data), headers=headers).json()



        elif method == 'DELETE':
            logger.info('现在开始进行delete请求')
            # excel的data中指定：0表示正常请求，1取数据库返回第一个值，2指定数据库返回第二个值，3指定删除规则
            if '1' in data.keys() and data['1'] == 1:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'],
                                                                    sql['code'])
                logger.info('数据库返回:' + str(sql_result))
                logger.info("excel取值获取数据库返回第%s位：" % data['1'])
                url_del = url + str(sql_result[0])
                logger.info("请求URL：%s" % url_del)
                request = requests.delete(url_del, headers=headers).json()
            elif '1' in data.keys() and data['1'] == 2:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'],
                                                                    sql['code'])
                logger.info('数据库返回:' + str(sql_result))
                logger.info("excel取值获取数据库返回第%s位：" % data['1'])
                url_del = url + str(sql_result[1])
                logger.info("请求URL：%s" % url_del)
                request = requests.delete(url_del, headers=headers).json()
            elif '1' in data.keys() and data['1'] == 3:
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'], sql['code'])
                for i in range(len(sql_result)):
                    if 'rule_id' in sql_result[i].keys():
                        url_d = url + str(sql_result[i]["rule_id"])
                        request = requests.delete(url_d, headers=headers).json()
                        logger.info("rule_id:%s删除处理成功!" % sql_result[i]["rule_id"])
                    elif 'id' in sql_result[i].keys():
                        url_d = url + str(sql_result[i]["id"])
                        request = requests.delete(url_d, headers=headers).json()
                        logger.info("规则ID:%s删除处理成功!" % sql_result[i]["id"])
                logger.info(sql['condition'] + "删除处理成功!")
            elif '1' in data.keys() and data['1'] == 0:
                logger.info("客户进行关闭会话请求！")
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'],
                                                                    sql['code'])
                logger.info('数据库返回:' + str(sql_result))
                url1 = url.format(sql_result[4], pp["visitor_id"])
                request = requests.delete(url1, headers=header).json()
            elif sql['1'] == 1:
                logger.info("批量删除自定义问答请求！")
                sql_result = getMysqlInfo(NC.config).get_mysql_info(sql['my_sql'],
                                                                    sql['condition'], sql['code'])
                a = ''
                for i in range(len(sql_result)):
                    a = a + str(sql_result[i]["id"]) + ','
                data['ids'] = a
                request = requests.delete(url, data=data, headers=headers).json()

            elif sql['1'] == 0:
                request = requests.delete(url, data=data, headers=headers).json()
            else:
                request = requests.delete(url, headers=headers).json()

        else:
            logger.info('请求方法未知！请核对后在尝试！')
        return request


if __name__ == '__main__':
    data = {"username": "emhhbmcwMDE=", "password": "MTIzNDU2", "forceFlag": "true"}

    url = 'https://testznkf.citydo.com.cn/v1/staff/login'

    sql = {}

    # DELETE,PUT,POST_del,POST_word,POST2,POST1,POST,POST_file,GET,GET_kh
    hh = httpRequest().httpGet(url, 'POST1', data, sql)
    print(hh)
