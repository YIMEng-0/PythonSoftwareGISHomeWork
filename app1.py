from bottle import route, run, static_file, template, request
from bottle import jinja2_view as view, jinja2_template as template

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


@route('/hello')
def index():
    return template('templates/test_vue.html')

@route('/uploadfile')
def upload():

    print("000000")
    return template('templates/form.html')


# 重新构建的上传代码块
@route('/', method='POST')
def index():
    # fname = request.files.get('upload_file')
    # fname = request.forms.get('textfield')
    fname = request.files['fileField']
    if fname:
        # t = time.strftime('%Y%m%d%H%M%S')
        new_fname = r'./Standard_Spectral_Data/' + fname.filename
        fname.save(new_fname)  #保存文件到指定路径

        # return '<img src=%s>' %  new_fname # 返回到指定的界面，目前不需要返回到加载的图片的位置
        print("文件上成功！")
        return template('templates/光谱仪定标.html', config=fname)
    else:
        return template('templates/光谱仪定标.html', config=fname)


# <name:filter> or <name:filter:config>
@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='./static')


# 将png 的文件放在 ./static 文件夹中，将图片进行显示，这个 filename 可以是上面定义的生成的光谱图像，直接生成传递到前端进行显示
# filename 可以修改为一个确定的照片
# @route('/images/<filename:re:.*\.png>')

@route('/images/<filename:re:.*\.png>')
def send_image(filename):
    return static_file(filename, root='./static/')


# 模板要放到正确的templates目录下
# templates和app.py在同级目录下
@route('/templates/form')
# @view('templates/form.html')
def tem():
    # writeIni()
    config = readIni('./static/Param.ini')
    config['start_hour'] = '%02d' % int(config['start_hour'])
    config['end_hour'] = '%02d' % int(config['end_hour'])
    return template('templates/form.html', config=config)


@route('/templates/光谱曲线绘制')
def tem():
    # writeIni()
    config = readIni('./static/Param.ini')
    config['start_hour'] = '%02d' % int(config['start_hour'])
    config['end_hour'] = '%02d' % int(config['end_hour'])
    return template('templates/光谱曲线绘制.html', config=config)

@route('/templates/光谱仪定标')
def tem():
    # writeIni()
    config = readIni('./static/Param.ini')
    config['start_hour'] = '%02d' % int(config['start_hour'])
    config['end_hour'] = '%02d' % int(config['end_hour'])
    return template('templates/光谱仪定标.html', config=config)


# 测量相关配置.html 的绑定以及打开
@route('/templates/测量相关配置')
def tem():
    # writeIni()
    config = readIni('./static/Param.ini')
    config['start_hour'] = '%02d' % int(config['start_hour'])
    config['end_hour'] = '%02d' % int(config['end_hour'])
    return template('templates/测量相关配置.html', config=config)


@route('/templates', method='POST')
def tem():
    # paras = {}
    # paras['photo_type'] = 'JR_update'
    # updateIni(paras, './static/test.ini')
    forms = {}
    forms['spectrum_id'] = request.forms.get('spectrum_id')
    forms['net_mode'] = request.forms.get('net_mode')
    forms['acq_cycle'] = request.forms.get('acq_cycle')
    forms['start_hour'] = request.forms.get('start_hour').split(':')[0]
    forms['end_hour'] = request.forms.get('end_hour').split(':')[0]

    forms['optical_fiber'] = request.forms.get('optical_fiber')
    forms['target_light'] = request.forms.get('target_light')
    forms['weak_light'] = request.forms.get('weak_light')
    forms['init_time'] = request.forms.get('init_time')
    forms['count_per_spectral'] = request.forms.get('count_per_spectral')

    forms['ftp_host'] = request.forms.get('ftp_host')
    forms['ftp_port'] = request.forms.get('ftp_port')
    forms['ftp_usrname'] = request.forms.get('ftp_usrname')
    forms['ftp_pwd'] = request.forms.get('ftp_pwd')

    forms['server_ip'] = request.forms.get('server_ip')
    forms['server_port'] = request.forms.get('server_port')
    updateIni(forms, './static/Param.ini')
    # return templates('<p>{{forms_value}}</p>', forms_value=forms)
    return template('templates/submit.html')


def readIni(path):
    cf = configparser.ConfigParser()
    cf.read(path)
    secs = cf.sections()
    paras = {}
    for sec in secs:
        opts = cf.options(sec)
        for opt in opts:
            value = cf.get(sec, opt)
            key = opt
            paras[key] = value


    return paras


def updateIni(paras, path):
    cf = configparser.ConfigParser()
    cf.read(path)
    secs = cf.sections()
    for sec in secs:
        opts = cf.options(sec)
        for opt in opts:
            value = paras[opt]
            cf.set(sec, opt, value)
    cf.write(open(path, "w"))
    return paras


def writeIni():
    config = configparser.ConfigParser()
    config['SPECTRUM'] = {'SPECTRUM_ID': 1,
                          'NET_MODE': False,
                          'ACQ_CYCLE': 10,
                          'START_HOUR': 9,
                          'END_HOUR': 20,
                          # 'RUN_MODE': 0,
                          }
    config['DEVICE'] = {'OPTICAL_FIBER': 8,
                        'TARGET_LIGHT': 30000,
                        'WEAK_LIGHT': 1000,
                        'INIT_TIME': 5,
                        'COUNT_PER_SPECTRAL': 9,
                        }
    config['FTP'] = {'FTP_HOST': '47.94.215.67',
                     'FTP_PORT': '21',
                     'FTP_USRNAME': 'Username',
                     'FTP_PWD': 'password',
                     }
    config['SERVER'] = {'SERVER_IP': '101.200.209.105',
                        'SERVER_PORT': '8087',
                        }
    with open('./static/Param.ini', 'w') as configfile:
        config.write(configfile)

    # Changes in templates files will not trigger a reload.


# Please use debug mode to deactivate templates caching.
# make sure not to use the debug mode on a production server
run(host='localhost', port=8088, reloader=True, debug=True)
# run(host='localhost', port=8088)
