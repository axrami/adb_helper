This will pass commands to all connected devices.

Requirements: ADB and Ruby. Place in path usage below.

ex. $adb_helper.rb power

install: input install path as argument
uninstall: input package name as argument
wireless: opens debug port and connects, must be on same network
usb: returns devices to usb mode
log: prints log to file, provide file name as argument
pull: copies files to current directory
kill_all: kills all background processes
text: arguent is passed as text to device
open: opens the MainActivity of the package provided
key: shell input keyevent, pass key number

events: power, menu, back, home, call, endcall, volup, voldown, camera, explorer