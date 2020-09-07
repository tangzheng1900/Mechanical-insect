# -*- coding: utf-8 -*-
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : manage.py
# @Software: PyCharm

from interface_auto_cases.public.config import config
import pymysql
from interface_auto_cases.public.logger import Log
import time
import interface_auto_cases.conf.NacosConfig as NC
import interface_auto_cases.main as v

now = time.strftime('%Y-%m-%d_%H_%M_%S')
logger = Log('get_mysql_info', NC.log_path)


class getMysqlInfo:
    def __init__(self, c):
        self.config = c
        logger.info("本次数据库调用配置成功！")

    def get_cnn(self):
        # 出入获取的配置文件，建立游标
        cnn = pymysql.connect(**self.config)
        return cnn

    def auto_testcase(self, condition):  # 自动获取测用例
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 传入sql语句，对应字段值
        cursor.execute("select * from testcase where version=%s ORDER BY addtime DESC", (condition,))
        desc = cursor.description  # 获取字段的描述，默认获取数据库字段名称，重新定义时通过AS关键重新命名即可

        result = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()]
        cnn.close()
        logger.info("查询测试库用例结果调用成功！{}".format(result))
        return result

    def auto_table(self, condition):  # 自动获取项目表单
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 传入sql语句，对应字段值
        cursor.execute("select * from environment where version=%s ORDER BY addtime DESC LIMIT 10", (condition,))
        desc = cursor.description  # 获取字段的描述，默认获取数据库字段名称，重新定义时通过AS关键重新命名即可

        result = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()]

        if eval(result[0]["dbconfig"])["database"] in eval(NC.table):
            result = eval(NC.table)[eval(result[0]["dbconfig"])["database"]]
        else:
            logger.info("查询数据库不存在，请创建对应项目表！")
        cnn.close()
        logger.info("查询测试库表单结果调用成功！{}".format(result))
        return result

    def auto_version(self, condition):  # 自动获取项目配置
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 传入sql语句，对应字段值
        cursor.execute("select * from environment where version=%s", (condition,))
        desc = cursor.description  # 获取字段的描述，默认获取数据库字段名称，重新定义时通过AS关键重新命名即可

        result = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()]

        cnn.close()
        logger.info("查询项目配置结果调用成功！{}".format(result))
        return result

    def auto_insert(self):  # 自动生成对应表单sql插入语句
        list_1 = {}
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 执行SQL语句
        cur = cursor.execute("select * from autotest." + testtable)
        # 查看数据库数据
        data = cursor.description
        data_1 = []
        test = []
        for i in range(len(data)):
            data_1.append(data[i][0])
            # print(data[i][0])
            test.append('%(' + data[i][0] + ')s')  # 生成value数列
            list_1[data[i][0]] = ''
        table_sql = "INSERT INTO " + testtable + " (" + ','.join(data_1) + ")" + " VALUES " + "(" + ','.join(test) + ")"
        logger.info("插入数据库sql拼接成功！%s" % table_sql)
        return table_sql

    def Instert_mysql(self, data):
        sql = getMysqlInfo(NC.config).auto_insert()
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        try:
            # 传入sql语句，对应字段值
            cursor.executemany(sql, data)
            cnn.commit()
            logger.info('sql写入统计测试记录成功！%s' % data)
        except Exception as e:
            logger.info('sql写入统计测试记录失败！！！%s' % e)
            raise e
        cnn.close()

    def Instert_case_return(self, data):  # 插入用例返回结果
        if 'msg' not in data.keys():
            data['msg'] = ''
        if 'sql_result' not in data.keys():
            data['sql_result'] = ''
        sql = 'UPDATE testcase SET actually="' + data["actually"] + '",sql_result="' + data[
            "sql_result"] + '",result="' + data["result"] + '",msg="' + str(data["msg"]) + '" where id=' + str(
            data["id"])
        logger.info('写入sql语句记录！！！%s' % sql)
        logger.info('写入sql数据记录！！！%s' % data)
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        try:
            # 传入sql语句，对应字段值
            cursor.execute(sql)
            cnn.commit()
            logger.info('sql写入统计测试记录成功！')
        except Exception as e:
            logger.info('sql写入统计测试记录失败！！！%s' % e)
            raise e
        cnn.close()

    def get_mysql_info(self, my_sql, condition, code):
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 传入sql语句，对应字段值
        cursor.execute(my_sql, (condition,))
        desc = cursor.description  # 获取字段的描述，默认获取数据库字段名称，重新定义时通过AS关键重新命名即可
        if code == 1:  # 查询所有的
            result = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()]
        elif code == 0:  # 查询一条信息
            result = cursor.fetchone()
            # print(result)
        # cursor.close()
        cnn.close()
        logger.info("用例查询数据库调用成功！")
        return result

    def get_mysql_info_test(self, my_sql, code):
        cnn = self.get_cnn()
        cursor = cnn.cursor()
        # 传入sql语句，对应字段值
        cursor.execute(my_sql)
        desc = cursor.description  # 获取字段的描述，默认获取数据库字段名称，重新定义时通过AS关键重新命名即可
        if code == 1:  # 查询所有的
            data_dict = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchall()]  # 列表表达式把数据组装起来
        elif code == 0:  # 查询一条信息
            data_dict = [dict(zip([col[0] for col in desc], row)) for row in cursor.fetchone()]  # 列表表达式把数据组装起来
        cnn.close()
        # print(data_dict)
        result = {'restult': "", 'sum': '', 'ok': '', 'fail': '', 'error': '', 'error_1': ''}
        result['restult'] = data_dict[0]['restult']

        sum = []
        ok = []
        fail = []
        error = []
        error_1 = []
        for i in range(1, len(data_dict) + 1):
            ii = len(data_dict) - i
            sum.append(data_dict[ii]['sum'])
            ok.append(data_dict[ii]['ok'])
            fail.append(data_dict[ii]['fail'])
            error.append(data_dict[ii]['error'])
            error_1.append(data_dict[ii]['error_1'])
        result['sum'] = sum
        result['ok'] = ok
        result['fail'] = fail
        result['error'] = error
        result['error_1'] = error_1
        # print(result)
        logger.info("测试结果数据库调用成功！")
        return result


# project_info = getMysqlInfo(NC.config).auto_version(v.ver)  # 获取项目配置
project_info = getMysqlInfo(NC.config).auto_version("V0.3.5")  # 获取项目配置
project_url = project_info[0]["project_url"]  # 获取项目路径
smtp = project_info[0]["smtp"]  # 获取项目邮箱配置
# table = eval(project_info[0]["dbconfig"])["database"]   # 获取测试数据表单
if eval(project_info[0]["dbconfig"])["database"] in eval(NC.table):
    testtable = eval(NC.table)[eval(project_info[0]["dbconfig"])["database"]]
else:
    logger.info("对应配置表单不出存在！")

if __name__ == '__main__':
    data = {"id": 10, 'actually': 'ok', 'sql_result': '', 'result': 'pass', 'msg': ''}
    sql_result = getMysqlInfo(NC.config).Instert_case_return(data)

    data = [{
        'restult': "{'testname': '质量保障部—章广华', 'time': '2019-11-11 11:55:14', 'sumtime': '0:00:00.125677', 'testresult': '共 1 条接口用例，错误 1 条', 'tonggl': '0.00%'}",
        'sum': 1, 'ok': 0, 'fail': 0, 'error': 1, 'error_1': '100.00%', 'date': '2019-11-11_11_55_13'}]
    # sql_result = getMysqlInfo(Allpath.db_conf_path, 'config1').Instert_mysql(data)
    # sql_result=getMysqlInfo(Allpath.db_conf_path,'config1').get_mysql_info_test("select * from znkf ORDER BY date DESC LIMIT 10;",1)
    # sql = getMysqlInfo(Allpath.db_conf_path, 'config1').auto_insert()
    print(sql_result)
