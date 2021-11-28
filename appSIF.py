from bottle import route, run, static_file, template, request, hook
from bottle import jinja2_view as view, jinja2_template as template
from jinja2 import Template
import os
import json
import SIF


@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='./static')


@route('/')
def index():
    return template('templates/sif.html')


@route('/1', method='POST')
def backData():

    upload = request.files.get('waveFile')
    upload.save(r'./waveFile')
    return 'ok'


@route('/getFLD', method='POST')
def getFLD():
    sifFLD = []
    a, b = SIF.FLD(r'./waveFile')
    for sif in a:
        sifFLD.append([688, sif])
    for sif in b:
        sifFLD.append([760, sif])
    print(sifFLD)
    return json.dumps(sifFLD)


@route('/getSFM', method='POST')
def getSFM():
    sifSFM = []
    a, b = SIF.SFM(r'.\waveFile')
    for sif in a:
        sifSFM.append([688, sif])
    for sif in b:
        sifSFM.append([760, sif])
    print(sifSFM)
    return json.dumps(sifSFM)


@route('/para/<name>')
def send_static(name):
    if name == 'FLD.txt':
        if os.path.exists("./static/para/FLD.txt"):
            os.remove("./static/para/FLD.txt")
        SIF.FLD('./waveFile', True)
    else:
        if os.path.exists("./static/para/SFM.txt"):
            os.remove("./static/para/SFM.txt")
        SIF.SFM('./waveFile', True)
    return static_file('/para/'+name, root='./static')


run(host='localhost', port=8088, reloader=True, debug=True)
