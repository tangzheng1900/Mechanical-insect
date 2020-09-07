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
    name = str(random.randint(0, 18))

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
    # 钉钉智能消息机器人AI虚拟机器人
    # url='https://oapi.dingtalk.com/robot/send?access_token=746c8737b87ebb1d394e8790d272846789a73fc263c284d1de43c21162fe642e'
    # url='https://oapi.dingtalk.com/robot/send?access_token=8a41242fd2858c2614077a9f74b503623c0cf87b5db7bdb35f3f983b3de52f1d'
    # 测试地址
    # url='https://oapi.dingtalk.com/robot/send?access_token=9abe37c6a640422cb85c9a877bb026b0b9029378890c5f14fcc106be9ab5725e'
    headers = {"Content-Type": "application/json"}
    data = {
        "actionCard": {
            "title": "乔布斯 20 年前想打造一间苹果咖啡厅，而它正是 Apple Store 的前身",
            "text": "![screenshot](https://gw.alicdn.com/tfs/TB1ut3xxbsrBKNjSZFpXXcXhFXa-846-786.png)"
                    "### 乔布斯 20 年前想打造的苹果咖啡厅" + "\n" +
                    "Apple Store 的设计正从原来满满的科技感走向生活化，而其生活化的走向其实可以追溯到 20 年前苹果一个建立咖啡馆的计划",
            "btnOrientation": "0",
            "singleTitle": "阅读全文",
            "singleURL": "https://www.dingtalk.com/"
        },
        "msgtype": "actionCard"
    }
    # data = {
    #     "msgtype": "markdown",
    #     "markdown": {
    #         "title": "项目质量控制数据统计报告",
    #         "text": "#### 项目质量控制数据统计报告【Python】\n" +
    #                 "> 【测试人员】:" + str(text['testname']) + "\n" +
    #                 "\n> 【开始时间】:" + str(text['time']) + "\n" +
    #                 "\n> 【合计耗时】:" + str(text['sumtime']) + "\n" +
    #                 "\n> 【本次结果】:" + str(text['testresult']) + "\n" +
    #                 "\n> 【通过率】:" + str(text['tonggl']) + "\n" +
    #                 "> ![screenshot](http://autotest-report.oss-cn-hangzhou.aliyuncs.com/report/" + name + ".jpg)\n" +
    #                 "> ###### " + now[0:10] + " 发布 [在线查看报告详情](http://47.111.14.23:8500/) \n"
    #     },
    #     "at": {
    #         "atMobiles": [
    #             "18267199586",
    #             "13111595333"
    #         ],
    #         "isAtAll": "false"
    #     }
    # }
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
    run()
