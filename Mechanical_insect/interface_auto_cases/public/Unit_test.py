# -*- coding: utf-8 -*-
# @Author  : zgh
# @Email   : 849080458@qq.com
# @File    : manage.py
# @Software: PyCharm

import unittest, time
from ddt import ddt, data, unpack
from interface_auto_cases.public.config import config
from interface_auto_cases.public.readExcel import Mysql_Casedata
from interface_auto_cases.public.httpRequest import httpRequest
import interface_auto_cases.conf.NacosConfig as NC
from interface_auto_cases.public.logger import Log
from interface_auto_cases.conf import Allpath
import interface_auto_cases.main as v
from interface_auto_cases.public.get_mysql_info import getMysqlInfo as gmi

logger = Log('Unit_test', NC.log_path)

h = Mysql_Casedata(v.ver).mysql_Casedata()
data2 = h
mode = config().read_config(Allpath.case_conf_path, 'FLAG', 'mode')


@ddt  # 用ddt装饰我的测试类
class testHttpRequset(unittest.TestCase):
    def setUp(self):
        logger.info("============我要开始测试了===============")

    @data(*data2)  # 用data 来装饰我的测试用例
    # 加一个* 号可以进行区分单个执行
    @unpack
    def test_znkf(self, id, method, url, data, code, case_name, sql):
        logger.info('正在执行第%s条用例' % id)
        result_dict = {}
        logger.info("当前请求内容_URL：{}；method：{}；data：{}；sql：{}".format(url, method, data, sql))
        result = httpRequest().httpGet(url, method, data, sql)
        result_dict["id"] = id
        result_dict["actually"] = result['code']
        # 判断请求返回内容是否包含key值：data
        if 'data' in result.keys():
            logger.info('接口返回data%s' % result)
            result_dict["msg"] = result['data']
            if 'message' in result.keys():
                logger.info('接口返回message%s' % result)
                result_dict["msg"] = result['message']
        try:
            # 断言对比(期望值，实际返回值)
            self.assertEqual(code, result['code'])
            result_dict['result'] = 'pass'
            logger.info('用例code比对成功！实际返回：%s' % result['code'])
        except Exception as e:
            result_dict['result'] = 'fail'
            logger.info('用例code比对失败！实际返回：%s' % result['code'])
            gmi(NC.config).Instert_case_return(result_dict)
            raise e
        logger.info("返回数据写入excel%s" % result_dict)
        gmi(NC.config).Instert_case_return(result_dict)
        time.sleep(0.3)

    def tearDown(self):
        logger.info("===============我要结束测试了！==================")


if __name__ == '__main__':
    unittest.main()
