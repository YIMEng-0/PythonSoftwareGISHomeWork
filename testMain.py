# import os
# import time
import datetime

print('Hello World!')
print('Time is ', datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S %A'))
print('__name__ value: ', __name__)


def main():
    print('this message is from main function');


def test():
    print("Hello This Is My ... Method");


'''
    直接运行python程序时，__name__的值为“__main__”
    而在其它程序中导入.py文件运行时，__name__的值为文件名，即模块名
    进行了功能的测试，在自己的文件夹中是使用 main 的意思 ，别的文件进行调用的时候就是文件的名字，这个时候测试的代码就不会被打印出来
'''
if __name__ == '__main__':
    main();  # 直接调用主方法，进行打印即可
    test();
