import zipfile
import os
import shutil
# 将参数计算成功之后，将计算的结果使用压缩包的形式进行发送到前端

startdir = "./out"  #要压缩的文件夹路径
file_news = startdir +'.zip' # 压缩后文件夹的名字
z = zipfile.ZipFile(file_news,'w',zipfile.ZIP_DEFLATED) #参数一：文件夹名
for dirpath, dirnames, filenames in os.walk(startdir):
    fpath = dirpath.replace(startdir,'') #这一句很重要，不replace的话，就从根目录开始复制
    fpath = fpath and fpath + os.sep or ''#这句话理解我也点郁闷，实现当前文件夹以及包含的所有文件的压缩
    for filename in filenames:
        z.write(os.path.join(dirpath, filename),fpath+filename)
        print ('压缩成功')
z.close()

# 移动文件夹示例
# 将参数的文件移动到 result 文件夹中使用前端的按钮可以进行文件的下载
# 进行文件移动的代码的重写，向前端返回一个计算结束后面的压缩包
if not os.path.exists("./static/result/out.zip"):
    shutil.move("./out.zip", "./static/result/")
