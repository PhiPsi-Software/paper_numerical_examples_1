# 3D点三次样条曲线光滑处理. 调用csaps库.
# 注:csaps函数并不能处理闭合曲线.
# Written by Fang Shi.
# Version 1.0, 2021-11-01.

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from csaps import csaps

# -----------------
#    Read files
# -----------------
f = open('Tem_Input_Points.txt', "r")
line = f.readline()
data_list = []
while line:
    num = list(map(float,line.split()))
    data_list.append(num)
    line = f.readline()
f.close()
n = (len(data_list))
data_array = np.array(data_list)

# -----------------
#   Call csaps
# -----------------
theta = np.linspace(0, 2*np.pi, n)
#theta = np.linspace(0, 2*np.pi, n+1) #首尾相接
#theta = np.linspace(0, 5, n+1) #首尾相接


x = data_array[:,0]
y = data_array[:,1]
z = data_array[:,2]

#首尾相接
#x = np.append(x, [data_array[0,0]], axis=0)
#y = np.append(y, [data_array[0,1]], axis=0)
#z = np.append(z, [data_array[0,2]], axis=0)

data = [x, y, z]

Integer_number = 10

theta_i = np.linspace(0, 2*np.pi, n*Integer_number-(Integer_number-1))
#theta_i = np.linspace(0, 2*np.pi, (n+1)*Integer_number-(Integer_number-1)) #首尾相接
#theta_i = np.linspace(0, 5, (n+1)*Integer_number-(Integer_number-1)) #首尾相接
data_i = csaps(theta, data, theta_i, smooth=0.99)

# ------------------------
#   提取数据（全部提取）
# ------------------------
xi = data_i[0, :]
yi = data_i[1, :]
zi = data_i[2, :]

# ------------------------
#仅提取原点对应位置的点
# ------------------------
new_points = np.zeros((n,3))
for i in range(0,n):
    new_points[i,0] = data_i[0, ((i+1)*Integer_number-(Integer_number-1))-1]
    new_points[i,1] = data_i[1, ((i+1)*Integer_number-(Integer_number-1))-1]
    new_points[i,2] = data_i[2, ((i+1)*Integer_number-(Integer_number-1))-1]

# ------------------------
#    保存数据
# ------------------------
#np.savetxt("Tem_Output_Points.txt", data_i.transpose())  #转置后保存
np.savetxt("Tem_Output_Points.txt", new_points)

# ----------------
#    绘图
# ----------------
# fig = plt.figure(2)
# ax = fig.add_subplot(111, projection='3d')
# ax.set_facecolor('none')
# ax.plot(x, y, z, '.:')     #绘制输入数据点
# for i in range(len(x)):
#    ax.text(x[i],y[i],z[i],i,color = "b")
# ax.plot(xi, yi, zi, '-')
# ax.plot(new_points[:,0], new_points[:,1], new_points[:,2], 'ro')   #绘制输出数据点
# for i in range(len(new_points)):
#    ax.text(new_points[i,0],new_points[i,1],new_points[i,2],i,color = "r")
# plt.show()
