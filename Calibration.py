# 读取数据文件，计算定标参数，保存定标参数
# Yangkai，2021/11/19
import numpy as np
import matplotlib.pyplot as plt
import numpy.linalg


def cal_dif(matrix_data, light_number):
    """
    计算传入的二位列表，以第1列为标准，计算其它列到第1列的差值
    :param matrix_data: 浮点数，二位列表，每一列代表一根光纤的测量值
    :param light_number: 整数，光纤个数
    :return: 返回光纤个数-1的二维列表，其它光纤同波段下距第1根光纤的差值
    """
    difference = []
    try:
        for row1 in range(1, light_number):
            dis = []
            for col1 in range(0, len(matrix_data[0])):
                temp_dis = matrix_data[row1][col1] - matrix_data[0][col1]
                dis.append(temp_dis)
                # print("temp_dis:", temp_dis)
            difference.append(dis)
            # print(dis)
        # print(difference)
    except IndexError:
        print("Error: 索引超出列表范围！请检查传入列表的维度")
    finally:
        return difference


def import_file(filename):
    """
    读取sps光谱数据，忽略波段，只读取DN值
    :param filename: 文件名
    :return: 返回该文件DN值的一维列表
    """
    fo = open(filename, "r+")
    data = []
    try:
        print("当前正在读取：", fo.name)
        for row1 in fo.readlines()[26:]:  # 从26行开始读取，跳过文件头
            line = row1.strip()  # strip函数删掉每一行数字前面的空格
            data.append(float(line[13:]))  # 一个文件的数据放进一个列表
    except IOError:
        print("Error: 没有找到文件或读取失败")
    except IndexError:
        print("Error: 索引超出列表范围，请检查文件内容！")
    else:
        print("文件读取成功！")
    finally:
        fo.close()
        return data


def ployfit(m, n, x, y, lamda):
    """
    对输入的参数进行M次多项式的拟合，返回拟合的多项式系数
    :param m: 拟合的多项式阶数
    :param n: 输入拟合数据的个数
    :param x: 待拟合的x，即各光照强度
    :param y: 待拟合的y，即各光照强度下的差值Δ
    :param lamda: 正则项系数，默认为0，即无正则项
    :return: 多项式系数的列表
    """
    # print("\n输入参数为：M=%d, N=%d, x_n=(%.4f,%.4f,%.4f), t_n=(%.4f,%.4f,%.4f)" % (
    # M, N, x_n[0], x_n[1], x_n[2], t_n[0], t_n[1], t_n[2]))
    order = np.arange(m + 1)        # 生成一个从0-m的列表
    order = order[:, np.newaxis]    # 提取所有行，升维，变成m*1的二维矩阵
    e = np.tile(order, [1, n])      # 在行方向上复制1次，列方向上复制n次
    x_t = np.power(x, e)            # 对传进来的x，求矩阵
    X = np.transpose(x_t)
    a = np.matmul(x_t, X) + lamda * np.identity(m + 1)  # X.T * X
    b = np.matmul(x_t, y)   # X.T * T
    # numpy.linalg中的函数solve可以求解形如 Ax = b 的线性方程组
    w = numpy.linalg.solve(a, b)
    # w = np.matmul(np.linalg.inv(a), b)  # aW = b => (X.T * X) * W = X.T * T
    return w


def ployval(args, x):
    """
    根据多项式系数，计算x处的y值
    :param args: 多项式系数，一维列表
    :param x: 待求点的x
    :return:  待求点的y
    """
    y = 0.0
    try:
        if len(args) == 0:
            print("输入的阶数为0！无法拟合！")
        else:
            # y1 = args[0] + args[1]*x + args[2]*x*x
            for rank in range(0, len(args)):
                y += args[rank] * (x ** (len(args)-rank-1))     # y = (w_0 *　x^2) + (w_1 * x^1) + (w_2 * x^0)
    except IndexError:
        print("Error: 索引超出列表范围！")
    finally:
        return y


# 画图
def draw_pic(matrix_data, title, pic_num):
    """
    画图函数
    :param matrix_data: 传入的二维矩阵
    :param title: 图标题和保存的文件名，用同一个字符串
    :param pic_num: 是第几副图
    """
    font = {'family': 'Times New Roman', 'size': 30, 'weight': 'bold'}
    n = list(range(350, 1021))
    plt.figure(num=pic_num, figsize=(15, 10))
    for i in range(0, len(matrix_data)):
        plt.plot(n, matrix_data[i], linewidth=3, label='NO.'+str(i+2))
    plt.tick_params(labelsize=15)
    plt.xticks(np.linspace(350, 1020, 10))
    plt.xlim(340, 1030)
    plt.grid(linestyle=":", color="k")
    plt.xlabel('Wavelength(nm)', font)
    plt.ylabel('Intensity(DN)', font)
    plt.title(title, font)
    plt.legend(loc='upper right', frameon=True, fontsize=25)
    plt.savefig("./" + title + ".png", dpi=600)
    plt.show()
    print("绘制成功！图片已保存")


# 输出到文件
def export_file(matrix_data, filepath, filename):
    """
    输出到文件
    :param matrix_data: 要保存的数据
    :param filepath:    文件保存路径
    :param filename:    希望保存的文件名
    """
    try:
        with open(filepath+filename, 'w+') as fid:
            for row in range(0, len(matrix_data)):
                fid.write("%20.15f %20.15f %20.15f\n" % (matrix_data[row][0], matrix_data[row][1], matrix_data[row][2]))
    except IOError:
        print("ERROR: 输出失败！请检查路径、文件名以及数据！")
    else:
        print("文件保存成功！")
    finally:
        print("输出函数调用结束")

