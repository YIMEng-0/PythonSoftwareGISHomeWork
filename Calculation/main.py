import Calibration
# 读取文件
High = []
Mid = []
Low = []
path = '../Standard_Spectral_Data_1114/'
for i in range(1, 8):
    filename_high = path + 'Spectrum_' + str(i) + "_0_1.sps"
    filename_mid = path + 'Spectrum_' + str(i) + "_1.sps"
    filename_low = path + 'Spectrum_' + str(i) + "_1_1.sps"
    High.append(Calibration.import_file(filename_high))
    Mid.append(Calibration.import_file(filename_mid))
    Low.append(Calibration.import_file(filename_low))
diff_high = Calibration.cal_dif(High, 7)
diff_mid = Calibration.cal_dif(Mid, 7)
diff_low = Calibration.cal_dif(Low, 7)

# 开始拟合
# 计算多项式系数
my_M = 2
my_N = 3
my_lamda = 0
Polynomial_Coefficients = []  # 拟合的多项式系数
result = []  # 中等光强下，定标后的结果

# 计算结果的导出
savepath = "../out/"
for row in range(0, 6):
    temp_args = []
    temp_result = []
    temp_args1 = []
    temp_result1 = []
    args_dis = []
    result_dis = []
    for col in range(0, len(diff_low[0])):
        my_x_n = [diff_low[row][col], diff_mid[row][col], diff_high[row][col]]
        my_y_n = [Low[row + 1][col], Mid[row + 1][col], High[row + 1][col]]

        # 方法1：Numpy自带的多项式拟合函数
        temp_args.append(Calibration.np.polyfit(my_y_n, my_x_n, 2))
        func = Calibration.np.poly1d(temp_args[col])
        temp_result.append(Mid[row+1][col] - func(Mid[row+1][col]))
        # print("numpy自带的Polyfit：", temp_args[col])
        # print("numpy自带的Polyld ：", temp_result[col])

        # 方法2：自己写的多项式拟合函数
        temp_args1.append(Calibration.ployfit(my_M, my_N, my_y_n, my_x_n, my_lamda))
        temp_result1.append(Mid[row+1][col] - Calibration.ployval(temp_args[col], Mid[row+1][col]))
        # print("自己写的：", temp_args1[col])
        # print("自己写的：", temp_result1[col])

        dis_args = [temp_args[col][0]-temp_args1[col][2], temp_args[col][1]-temp_args1[col][1], temp_args[col][2]-temp_args1[col][0]]
        args_dis.append(dis_args)
        result_dis.append(temp_result[col] - temp_result1[col])

    Polynomial_Coefficients.append(temp_args)   # 保存的多项式参数：a*x^2 + b*x + c中的a,b,c
    result.append(temp_result)                  # 保存的定标结果
    Calibration.export_file(Polynomial_Coefficients[row], savepath, "Light_"+str(row+1)+".conf")
print("计算结束！")

Calibration.draw_pic(High, "1-High Light Intensity", 1)
Calibration.draw_pic(Mid, "1-Middle Light Intensity", 2)
Calibration.draw_pic(Low, "1-Low Light Intensity", 3)
Calibration.draw_pic(diff_low, "2-Low Light Difference", 4)
Calibration.draw_pic(diff_mid, "2-Middle Light Difference", 5)
Calibration.draw_pic(diff_high, "2-High Light Difference", 6)
Calibration.draw_pic(result, "Middle Light Calibration Difference(Numpy - Myself)", 7)


