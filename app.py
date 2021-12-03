from bottle import route, run, static_file, template, request
from bottle import jinja2_template as template
import os

"""
bottle 轻量级框架的简单学习，这个框架充当 Web 服务器，协调 代码与前端之间的交互
一个bottle程序分为四部分
1.import bottle
2.@route('/index')定义一个访问路径，这样从浏览器访问时就能访问自己定义的路径
3.定义一个与第2步route相应的处理函数，系统在看到@route标记后会自动调用其后边的这个函数。
4.调用run()函数。

from bottle import route, run

@route('/hello')
def hello():
    return "Hello World!" #返回给浏览器
    
run(host='localhost', port=8080)
"""
# 设置B/S 架构下面的网络应用的开始页面，进去之后直接显示光谱仪定标的界面
@route('/')
def index():
    return template('templates/光谱仪定标.html')

# 这个是和前端的上传文件控件进行的绑定，可以设置文件保存的路径
@route('/1', method='POST')
def backData():
    upload = request.files.get('Spectral_Data')
    upload.save(r'./Spectral_Data')
    return 'ok'

# # 将观光谱文件上传到另外一个文件夹中
# @route('/2', method='POST')
# def backData():
#     upload = request.files.get('Observed_Spectral_Data')
#     upload.save(r'./Observed_Spectral_Data')
#     return 'ok'

# 这个是和前端的按钮进行的绑定，点击按钮调用后端的 main.py 的脚本文件，进行图片的生成
@route('/getCalibration', method='POST')
def getCalibration():

    os.system("python main.py")

# 进行文件的下载，远程的下载文件
@route('/result/<name>')
def send_static(name):
    os.system("python zipFile.py")
    return static_file('/result/'+name, root='./static')

@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='/static/images/1-High Light Intensity.png')

# 进行配置参数的获取
@route('/obsconfig', method='POST')
def tem():
    # 使用数组或者某种存储容器存储表格中传递过来的相关参数
    # form = 'html' 里面的 name 进行获取
    forms = {}
    forms['DingBiao'] = request.forms.get('DingBiao')
    forms['GuangQian'] = request.forms.get('GuangQian')
    print(forms)

    return template('templates/光谱仪定标.html')


run(host='localhost', port=8088, reloader=True, debug=True)