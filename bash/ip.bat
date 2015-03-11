@echo off
mode con cols=80 lines=30
rem 设置公用变量
set net_interface="本地连接"
 
:CHOICE
color b
cls
echo *********************IP快速切换程序********************
echo ----【IP设置功能】---------------
echo -----1.修改“本地连接”的IP-----------
echo -----2.修改“本地连接1”的IP----------
echo -----3.修改本地连接为HOME_IP------
echo -----4.修改为自动获取-----
echo -----【系统功能】----------
echo -----r.重启网卡-----------
echo -----X.退出程序-----------
echo.
echo *********************Tools By WLH**********************
echo.注意“本地连接1”是网上邻居的连接名称！！！
 
:mu
set /p choice= 请输入您的选择：
IF NOT "%choice%"=="" SET choice=%choice:~0,1%
if /i "%choice%"=="1" goto home1_ip
if /i "%choice%"=="2" goto home2_ip
if /i "%choice%"=="3" goto home3_ip
if /i "%choice%"=="4" goto DHCP
if /i "%choice%"=="r" goto reboot
if /i "%choice%"=="X" goto END
echo.
echo.
echo 输入的选择不正确，请重新输入！
echo.
echo.
GOTO CHOICE
pause
 
:home1_ip
cls
echo.
echo 正在为本地连接设置IP,请等待...
echo.
echo 设置IP中...
set net_interface="本地连接"
 
:CHOICE1
set /p ip1= 请输入IP的最后一个网段：
IF NOT "%ip1%"=="" set /p yes1= 你确定IP正确吗（输入1回车表示确定）？：
IF  "%yes1%"=="" SET yes1="1"
IF NOT "%yes1%"=="" SET yes1=%yes1:~0,1%
if /i "%yes1%"=="1" goto ip111
if /i "%yes1%"==1 goto ip111
 
GOTO CHOICE1
 
:ip111
cls
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.%ip1% mask=255.255.255.0
echo 设置IP成功...设置网关中...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo 设置完成。
ipconfig
set /p q1= 按0键退出
IF NOT "%q1%"=="0" GOTO CHOICE
GOTO CHOICE8
 
:home2_ip
cls
echo.
echo 正在为本地连接1设置IP,请等待...
echo.
echo 设置IP中...
set net_interface="本地连接1"
 
:CHOICE2
set /p ip2= 请输入IP的最后一个网段：
IF NOT "%ip2%"=="" set /p yes2= 你确定IP正确吗（输入1回车表示确定）？：
IF  "%yes2%"=="" SET yes2="1"
IF NOT "%yes2%"=="" SET yes2=%yes2:~0,1%
if /i "%yes2%"=="1" goto ip222
GOTO CHOICE2
 
:ip222
cls
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.%ip2% mask=255.255.255.0
echo 设置IP成功...设置网关中...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo 设置完成。
ipconfig
set /p q2= 按0键退出
IF NOT "%q2%"=="0" GOTO CHOICE
GOTO CHOICE8
 
:home3_ip
cls
echo.
echo 正在设置IP为home_ip请等待...
echo.
set net_interface="本地连接"
echo 设置IP中...
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.111 mask=255.255.255.0
echo 设置IP成功...设置网关中...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo 设置网关成功...设置DNS中...
netsh interface ip set dns "%net_interface%" static 218.85.152.99
netsh interface ip add dns "%net_interface%" 218.85.157.99 index=2
pause |echo 任务完成,按任意键返回选择菜单。
GOTO CHOICE8
 
:DHCP
echo.
echo 正在设置IP为自动获取,请等待...
echo.
echo 设置IP中...
netsh interface ip set address name="%net_interface%" source=dhcp
echo 设置网关成功...设置DNS中...
netsh interface ip set dns "%net_interface%" source=dhcp
pause |echo 任务完成,按任意键返回选择菜单。
GOTO CHOICE8
 
:reboot
echo 重启网卡中...请稍等...
netsh interface set interface "%net_interface%" disabled
netsh interface set interface "%net_interface%" enable
pause |echo 任务完成,按任意键返回选择菜单。
GOTO CHOICE
 
:CHOICE8
:end
exit