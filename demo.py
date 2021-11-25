from bottle import route, run

# demo 为了部署到服务器上面
# @route('/')
# def index():
#     return 'Hello'

@route('/hello/')
def index():
    return 'Hello, world'

run(host='localhost', port=8088)