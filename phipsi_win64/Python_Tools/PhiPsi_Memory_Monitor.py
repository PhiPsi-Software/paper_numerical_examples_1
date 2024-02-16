#!/usr/bin/env python
# -*- coding: utf-8 -*-
# coding:gbk
import os, re
import time
import string
from colorama import init,Fore, Back, Style  #彩色输出(安装方法:pip install colorama)

#彩色输出模块colorama初始化
init(autoreset=True) #自动恢复默认颜色

print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + "  ****                                                              ****")
print(Fore.CYAN + "  ****                   PhiPsi Memory Monitor V1.2                 ****")
print(Fore.CYAN + "  ****                                                              ****")
print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + "  > Features:                                                           ")
print(Fore.CYAN + "    This tool is used to monitor memory usage of a specified program.   ")
print(Fore.CYAN + "    Successfully tested by using Python 3.9.1.                          ")
print(Fore.CYAN + "    --------------------------------------------------------------------")
print(Fore.CYAN + "  > Author:  Fang Shi,     Huaiyin Institute of Technology, China       ") 
print(Fore.CYAN + "  > Website: http://phipsi.top                                          ")
print(Fore.CYAN + "  > Email:   shifang@hyit.edu.cn                                        ")
print(Fore.CYAN + "  > Updated on 2021-08-15                                               ")
print(Fore.CYAN + "  **********************************************************************")
print(Fore.CYAN + " ")

# Version 1.0, 2018-12-17
# Version 1.1, 2021-02-07
# Version 1.2, 2021-08-15

def countProcessMemoey(processName,max_memory):
    pattern = re.compile(r'([^\s]+)\s+(\d+)\s.*\s([^\s]+\sK)')
    cmd = 'tasklist /fi "imagename eq ' + processName + '"' + ' | findstr.exe ' + processName
    result = os.popen(cmd).read()
    resultList = result.split("\n")
    for srcLine in resultList:
        srcLine = "".join(srcLine.split('\n'))
        if len(srcLine) == 0:
            break
        m = pattern.search(srcLine)
        if m == None:
            continue
        #由于是查看python进程所占内存，因此通过pid将本程序过滤掉
        if str(os.getpid()) == m.group(2):
            continue
        ori_mem = m.group(3).replace(',','')
        ori_mem = ori_mem.replace(' K','')
        ori_mem = ori_mem.replace(r'\sK','')
        memEach = int(ori_mem)
        if memEach > max_memory:
            max_memory = memEach
        cur_date_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) 
        print(cur_date_time +'  |  '+ m.group(1) + '  |  \tPID: ' + m.group(2) + '  |  '+Fore.GREEN+'\tMemory: %.2f'% (memEach * 1.0 /1024/1024), Fore.GREEN+'GB'+ Fore.WHITE+'  |  '+Fore.RED+'\tMax_Mem: %.2f'% (max_memory * 1.0 /1024/1024), Fore.RED+'GB')
    return max_memory
    #print "*" * 58

if __name__ == '__main__':
    #进程名
    ProcessName = 'PhiPsi_Win64.exe'
    max_memory = 0
    #ProcessName2 = "chrome.exe"

    while True:
        max_memory = countProcessMemoey(ProcessName,max_memory)
        #countProcessMemoey(ProcessName2)
        time.sleep(1)
