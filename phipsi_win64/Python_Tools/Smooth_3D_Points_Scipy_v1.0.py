# 3D点B样条曲线光滑处理. 调用scipy interpolate库.
# 注:并不能处理闭合曲线.
# Written by Fang Shi.
# Version 1.0, 2021-11-02.

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from scipy import interpolate
import cmath

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

# -------------------------------
#   Call interpolate.splprep
# -------------------------------
x = data_array[:,0]
y = data_array[:,1]
z = data_array[:,2]

#min_s = n-(2*n)**0.5
#max_s = n+(2*n)**0.5
#print (min_s)
#print (max_s)

tck, u = interpolate.splprep([x,y,z], k=3, s=2)    #k表示样条曲线的阶次1，3，5，默认为3；s越大越光滑，knots越少，默认为2
#tck, u = interpolate.splprep([x,y,z], k=3, s=28)    #k表示样条曲线的阶次1，3，5，默认为3；s越大越光滑，knots越少

x_knots, y_knots, z_knots = interpolate.splev(tck[0], tck)

# ------------------------
#   提取数据（全部提取）
# ------------------------
u_fine = np.linspace(0,1,n)
x_new, y_new, z_new = interpolate.splev(u_fine, tck)

# ------------------------
#    保存数据
# ------------------------
new_points = np.zeros((n,3))
for i in range(0,n):
    new_points[i,0] = x_new[i]
    new_points[i,1] = y_new[i]
    new_points[i,2] = z_new[i]
np.savetxt("Tem_Output_Points.txt", new_points)

# ----------------
#    绘图
# ----------------
# fig2 = plt.figure(2)
# ax3d = fig2.add_subplot(111, projection='3d')
# ax3d.plot(x, y, z, 'r*')  #绘制输入数据点
# for i in range(len(x)):
#    ax3d.text(x[i],y[i],z[i],i,color = "b")
# ax3d.plot(x_knots, y_knots, z_knots, 'go')   #绘制knots点
# ax3d.plot(x_new, y_new, z_new, 'orange')    #绘制拟合后的点所在曲线(绿色)
# ax3d.plot(x_new, y_new, z_new, color='orange', marker='P')  #绘制拟合后的点
# for i in range(len(x_new)):
#    ax3d.text(x_new[i],y_new[i],z_new[i],i,color = "green")
# plt.show()
# fig2.show()
# plt.show()