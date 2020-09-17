import unittest
import time, shutil
from interface_auto_cases.public.logger import Log
import requests
import random
import interface_auto_cases.conf.NacosConfig as NC

ver = ''


def run(version):
    global ver
    ver = version
    print(ver)
    logger = Log('main', NC.log_path)
    # 去随机数赋值图片名称
    name = str(random.randint(0, 30))

    from interface_auto_cases.public import Unit_test
    suite = unittest.TestSuite()  # 实例
    loader = unittest.TestLoader()
    # 测试模块
    suite.addTest(loader.loadTestsFromModule(Unit_test))

    now = time.strftime('%Y-%m-%d_%H_%M_%S')
    file_path = NC.html_path + '/' + now + '.html'

    import interface_auto_cases.HTMLTestRunner_zgh as htr
    with open(file_path, 'wb+') as file:
        # 实例化测试报告运行
        runner = htr.HTMLTestRunner(stream=file, verbosity=2, tester='质量保障部—章广华',
                                    title='项目质量控制数据统计【Python】',
                                    description='该测试报告仅体现某接口请求以及参数值验证情况。')
        # 传入测试运行对象
        runner.run(suite)
    import interface_auto_cases.public.get_mysql_info as gmi
    sqlinfo = "select * from " + gmi.testtable + " ORDER BY date DESC LIMIT 10;"
    text = eval(gmi.getMysqlInfo(NC.config).get_mysql_info_test(sqlinfo, 1)['restult'])
    logger.info('获取表单内容成功：%s' % text)
    # 钉钉智能消息机器人项目质量报告机器人
    # url='https://oapi.dingtalk.com/robot/send?access_token=6128ef1568799123702f701123c30b2c19f953c1f0a028b0c1a0598ccbf94481'
    # 测试地址
    # url='https://oapi.dingtalk.com/robot/send?access_token=9abe37c6a640422cb85c9a877bb026b0b9029378890c5f14fcc106be9ab5725e'
    headers = {"Content-Type": "application/json"}

    data = {
        "msgtype": "markdown",
        "markdown": {
            "title": "项目质量数据统计报告",
            "text": "#### 项目质量数据统计报告【test】\n" +
                    "> 【项目个数】:{}".format(6) + "\n" +
                    "\n> 【共计用例】:{}".format(3403) + "\n" +
                    "\n> 【成功率】:{}".format('87%') + "\n" +
                    "\n> 【失败率】:{}".format('10%') + "\n" +
                    "\n> 【错误率】:{}".format('3%') + "\n" +
                    "> ![screenshot](http://autotest-report.oss-cn-hangzhou.aliyuncs.com/report/" + name + ".jpg)\n" +
                    "> ###### " + now[0:10] + " 发布 [在线查看报告详情](http://172.16.25.46:82/admin/home/) \n"
        },
        "at": {
            "atMobiles": [
                "17681829051",
            ],
            "isAtAll": "false"
        }
    }
    # request = requests.post(url, json=data, headers=headers).json()
    # logger.info("钉钉机器人消息请求内容%s" % data)
    # logger.info('钉钉机器人消息请求成功%s' % request)

    shutil.copyfile(NC.html_path + '/' + now + '.html', NC.html_path + '/report/index.html')
    # 当前时间，邮件对象
    from interface_auto_cases.public.smtp import massageMail
    # name=['zhanggh@citydo.com.cn','sunb@citydo.com.cn','liyj@citydo.com.cn','zhanghx@citydo.com.cn','liyang@citydo.com.cn','wangm@citydo.com.cn','zhuxsz@citydo.com.cn','panyw@citydo.com.cn','xiongh@citydo.com.cn','chenrj@citydo.com.cn','chenq0148@citydo.com.cn','jinjl@citydo.com.cn','sunh@citydo.com.cn','chengf@citydo.com.cn','liuwenchao@citydo.com.cn','zhaoky@citydo.com.cn','xujm@citydo.com.cn','caoyq@citydo.com.cn','less@citydo.com.cn']
    # name=['zhanggh@citydo.com.cn',]
    # for i in range(len(name)):
    #     try:
    #         massageMail().Message(now,name[i])
    #         logger.info('发送邮箱为：%s' % name[i])
    #     except:
    #         continue
    logger.info('本次Python接口自动化框架执行完毕！%s' % time.strftime('%Y-%m-%d %H:%M:%S'))
    return text


if __name__ == '__main__':
    run('V0.3.5')
