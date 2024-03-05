#!/usr/bin/env python
# -*- coding: utf-8 -*-
#PhiPsi结果文件删除器
#作者: 师访, 淮阴工学院(2022)
import string
import os
import time
from colorama import init,Fore, Back, Style  #彩色输出(安装方法:pip install colorama)
import sys

#彩色输出模块colorama初始化
init(autoreset=True) #自动恢复默认颜色

print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + "  ****                                                              ****")
print(Fore.CYAN + "  ****              PhiPsi Results File Deleter V1.6                ****")
print(Fore.CYAN + "  ****                                                              ****")
print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + "  > Features:                                                           ")
print(Fore.CYAN + "    This tool is used to delete results files produced by PhiPsi.       ")
print(Fore.CYAN + "    This program is written in python.                                  ")
print(Fore.CYAN + "    --------------------------------------------------------------------")
print(Fore.CYAN + "  > Author:  Shi Fang from Huaiyin Institute of Technology, China       ") 
print(Fore.CYAN + "  > Website: http://phipsi.top                                          ")
print(Fore.CYAN + "  > Email:   shifang@hyit.edu.cn                                        ")
print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + " ")

# Version 1.1 (2021-05-22): Add '.igs','.step','.acis','.stp'.
# Version 1.2 (2021-07-23): Add '.in'.
# Version 1.3 (2021-08-01): Add '.bat'.
# Version 1.4 (2021-12-19): Add '.dat'.
# Version 1.5 (2022-07-24): Add '.fab' and '.frd'.
# Version 1.6 (2023-07-29): Add '.kpp'.

# current_folder= "D:\PhiPsi_Project\PhiPsi_Work\3D_Block_25x25x25_Fixed"   #不正确
# current_folder= "D:/PhiPsi_Project/PhiPsi_work/3D_Block_25x25x25_Fixed/"  #正确

#获得当前工作路径
current_folder_dat_file = 'current_folder.dat'
# print(current_folder_dat_file) 
with open(current_folder_dat_file) as files:    #通过with方法读取文件
    current_folder = files.readline()                 #读一行操作，并赋值给text
    # print(current_folder)  
    current_folder =current_folder.strip()
    # print(current_folder)                      #输出读取的内容
    current_folder =current_folder.replace('\\','/')   #反斜杠替换

#检查文件夹是否存在
Yes_Folder_Exists = os.path.exists(current_folder)
if(Yes_Folder_Exists==True):
    print(Fore.RED+"  Folder ",Fore.RED+current_folder,Fore.RED+" is found!")
else:
    print(Fore.RED+"  Error :: Input folder name is not found!'")
    sys.exit() 
    
#不删除的文件类型后缀
Keeped_File_Type = ('.apdl','.apdb','.boux','.bouy','.bouz','.elem','.node','.focx','.focy','.focz','.buxn','.buyn','.buzn','.ivex','.ivey','.ivez','.fbvl','.fbiv','.fbqn','.eqac','.bhpc','.wppg','.data','.mesh','.dofx','.dofy','.dofz','.iges','.igs','.step','.stl','.acis','.stp','.IGES','.IGS','.STEP','.STL','.ACIS','.STP','.bat','.in','.dat','.fab','.frd','.istn','.tpen','.bken','.rten','.hlen','.log','.x_t','.kpp','.surf','.m')
    
#假如文件夹存在,则执行删除操作
if(Yes_Folder_Exists==True):
    print(" ")
    print(Fore.YELLOW +'  >> Now begin to delete all results files......')
    #删除掉的文件数目计数器归零
    Deleted_Files_Counter = 0
    #删除掉的文件大小规律
    Deleted_Files_Size = 0
    c_Files = os.listdir(current_folder)
    #各文件循环
    for i_File in c_Files:
        #当前文件的全名
        c_Full_File_name = current_folder + i_File
        #检查当前名称是否是文件
        Yes_File = os.path.isfile(c_Full_File_name)
        #如果是文件
        if (Yes_File == True):
            #获取当前文件后缀
            c_Full_Type = os.path.splitext(i_File)[1]
            #print(c_Full_Type)
            c_Type   = c_Full_Type[0:5]
            #c_Type_4 = c_Full_Type[1:5]
            #检查是否属于不删除类型
            if c_Type in Keeped_File_Type:
                pass
            #elif c_Type_4 in Keeped_File_Type:
            #    pass
            else:
                #文件大小
                Deleted_Files_Size = Deleted_Files_Size + os.path.getsize(c_Full_File_name)
                #删除文件数目计数器更新
                Deleted_Files_Counter = Deleted_Files_Counter + 1
                #删除文件
                os.remove(c_Full_File_name)
                print(Fore.YELLOW +"    ",Fore.RED +c_Full_File_name,Fore.YELLOW +" deleted.")
print(Fore.MAGENTA+" ")                    
print(Fore.MAGENTA+"  >> ",Fore.MAGENTA+str(Deleted_Files_Counter),Fore.MAGENTA+" files were deleted.")
print(Fore.MAGENTA+"  >> Size of all deleted result files is %.3f" %(float(Deleted_Files_Size/1024.0/1024.0)),Fore.MAGENTA+" MB.")
print(Fore.MAGENTA+" ")  
# print(Fore.CYAN+"  >> Sleep for 1 second then exit.")
# time.sleep(1)
