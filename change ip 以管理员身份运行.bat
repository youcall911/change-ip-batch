@echo off
rem 强制获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
rem //设置变量
set NAME="以太网 3"
rem //以下属性值可以根据需要更改
set ADDR=192.168.0.150
set MASK=255.255.255.0
set GATEWAY=
set DNS1=
set DNS2=
rem //以上属性依次为IP地址、子网掩码、网关、首选DNS、备用DNS
echo 当前可用操作有：
echo 1 设置为静态IP
echo 2 设置为动态IP
echo 3 退出
echo 请选择后回车：
set /p operate=
if %operate%==1 goto 1
if %operate%==2 goto 2
if %operate%==3 goto 3

:1
echo 正在设置静态IP，请稍等...
rem //可以根据你的需要更改
echo IP地址 = %ADDR%
echo 掩码 = %MASK%
echo 网关 = %GATEWAY%
netsh interface ipv4 set address name=%NAME% static addr=%ADDR% mask=%MASK% gateway=%GATEWAY% >nul
echo 首选DNS = %DNS1%
netsh interface ip set dns name=%NAME% source=static addr=%DNS1% register=PRIMARY >nul
echo 备用DNS = %DNS2%
netsh interface ipv4 add dns name=%NAME% addr=%DNS2% >nul
echo **********已设置为静态IP：%ADDR%***********
timeout /t 1
exit

:2
echo 正在设置动态IP，请稍等...
echo 正在从DHCP自动获取IP地址...
netsh interface ip set address %NAME% dhcp
echo 正在从DHCP自动获取DNS地址...
netsh interface ip set dns %NAME% dhcp
echo **********已设置为动态IP地址***********
timeout /t 1
exit

:3
exit