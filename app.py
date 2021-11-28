from bottle import route, run, static_file, template, request
from bottle import jinja2_view as view, jinja2_template as template
import os

from jinja2 import Template
import configparser

"""
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
@route('/')
def index():
    return template('templates/光谱仪定标.html')

@route('/1', method='POST')
def backData():
    upload = request.files.get('Spectral_Data')
    upload.save(r'./Spectral_Data')
    return 'ok'

@route('/getCalibration', method='POST')
def getCalibration():
    os.system("python main.py")


run(host='localhost', port=8088, reloader=True, debug=True)