@echo off
rem ǿ�ƻ�ȡ����ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
rem //���ñ���
set NAME="��̫�� 3"
rem //��������ֵ���Ը�����Ҫ����
set ADDR=192.168.0.150
set MASK=255.255.255.0
set GATEWAY=
set DNS1=
set DNS2=
rem //������������ΪIP��ַ���������롢���ء���ѡDNS������DNS
echo ��ǰ���ò����У�
echo 1 ����Ϊ��̬IP
echo 2 ����Ϊ��̬IP
echo 3 �˳�
echo ��ѡ���س���
set /p operate=
if %operate%==1 goto 1
if %operate%==2 goto 2
if %operate%==3 goto 3

:1
echo �������þ�̬IP�����Ե�...
rem //���Ը��������Ҫ����
echo IP��ַ = %ADDR%
echo ���� = %MASK%
echo ���� = %GATEWAY%
netsh interface ipv4 set address name=%NAME% static addr=%ADDR% mask=%MASK% gateway=%GATEWAY% >nul
echo ��ѡDNS = %DNS1%
netsh interface ip set dns name=%NAME% source=static addr=%DNS1% register=PRIMARY >nul
echo ����DNS = %DNS2%
netsh interface ipv4 add dns name=%NAME% addr=%DNS2% >nul
echo **********������Ϊ��̬IP��%ADDR%***********
timeout /t 1
exit

:2
echo �������ö�̬IP�����Ե�...
echo ���ڴ�DHCP�Զ���ȡIP��ַ...
netsh interface ip set address %NAME% dhcp
echo ���ڴ�DHCP�Զ���ȡDNS��ַ...
netsh interface ip set dns %NAME% dhcp
echo **********������Ϊ��̬IP��ַ***********
timeout /t 1
exit

:3
exit