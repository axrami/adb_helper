# adb_helper

----
## description

> adb_helper will issue adb key event and shell commands to all connected devices

----
## commands
1.install: will install an apk to connected devices

    $adb_helper install ~/Development/android/ecosmart/EcoSmart.apk


2.uninstall: input package name as argument

    $adb_helper uninstall com.company.mobile.ecosmart

3.pull: copies files to current directory or specified directory

    $adb_heler pull sdcard/Robotium-Screenshots

4.kill_all: kills all background processes

5.text: pass text to devices

    $adb_helper text hello

6.open: opens the MainActivity of the package provided

    $adb_helper open com.company.mobile.ecosmart

7.key: pass any shell input  keyevent value to execute on all devices

    $adb_helper key 26

##Other acceptable commands
>No arguments are required and preform the inferred command on devices

    $adb_helper power

1. power
2. menu
3. back
4. home
5. call
6. endcall
7. volup
8. voldown
9. explorer
