#!/usr/bin/env ruby

devices = `adb devices`

devices = devices.split("\n")

devices.shift

device_ids = []

def usage
  puts "
  This will pass commands to all connected devices.

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
  "
end

if ARGV[0] == nil
  usage()
end

events = {"power" => 26, "menu" => 82, "back" => 4, "home" => 3, "call" => 5, "endcall" => 6, "volup" => 24, "voldown" => 25, "camera" => 27, "explorer" => 62}

devices.each do |device|
  device_ids << device.split("\t")[0]
end

def key_event device_id, keycode
  `adb -s #{device_id} shell input keyevent #{keycode}`
end

def install device_id
arg2 = ARGV[1]
  if arg2 == nil
    puts "input install path..."
  else
    puts "installing from #{arg2}..."
  `adb -s #{device_id} install #{arg2}`
    puts "done..."
  end
end

def uninstall device_id
  arg2 = ARGV[1]
  if arg2 == nil
    puts "input package name..."
  elsif arg2 == "ecosmart"
    `adb -s #{device_id} shell pm uninstall com.liveperson.mobile.ecosmart`
    puts "done..."
  else
    puts "uninstalling #{arg2}"
    `adb -s #{device_id} shell pm uninstall #{arg2}`
    puts "done..."
  end
end

def wireless device_id
  `adb -s #{device_id} shell getprop dhcp.wlan0.ipaddress >> ipaddress.txt`
  `adb -s #{device_id} tcpip 5555`
  f = File.open("ipaddress.txt", "r")
  f.each_line do |line|
    puts "connecting to #{line}"
    `adb -s #{device_id} connect #{line}`
  end
  f.close
  `rm ipaddress.txt`
end

def usb device_id
  `adb -s #{device_id} usb`
end

def log device_id
  arg2 = ARGV[1]
  arg3 = ARGV[2]

  if arg2 != nil && arg3 != nil
    `adb -s #{device_id} logcat -s #{arg2} > #{arg3}/#{device_id}.txt`
  elsif arg3 != nil
    `adb -s #{device_id} logcat > #{arg2}/#{device_id}.txt`
  else
    `adb -s #{device_id} logcat > #{device_id}.txt`
  end
end

def pull device_id
  arg2 = ARGV[1]
  if arg2 == nil && arg3 == nil
    puts "input path to pull"

  else
    `adb -s #{device_id} pull #{arg2}`

  end
end

def kill_all device_id
    puts "killing all background processes..."
    `adb -s #{device_id} shell am kill-all`
end

def text device_id
  arg2 = ARGV[1]
  `adb -s #{device_id} shell input text #{arg2}`
end

def open device_id
  arg2 = ARGV[1]
  if arg2 == nil
    puts 'input package name...'
  elsif arg2 == "ecosmart"
    `adb -s #{device_id} shell am start -n com.liveperson.mobile.ecosmart/com.liveperson.mobile.ecosmart.MainActivity`
  else
  `adb -s #{device_id} shell am start -n #{arg2}/#{arg2}.MainActivity`
  puts "opening #{arg2}..."
  end
end

def key device_id
  arg2 = ARGV[1]
  if arg2 == nil
    puts 'pass key event..'
  else
    `adb -s #{device_id} shell input keyevent #{arg2}`
  end
end


device_ids.each do |id|
  arg = ARGV[0]

  case arg
  when "install"
    install(id)
  when "uninstall"
    uninstall(id)
  when "wireless"
    wireless(id)
  when "usb"
    usb(id)
  when "log"
    log(id)
  when "pull"
    pull(id)
  when "kill_all"
    kill_all(id)
  when "text"
    text(id)
  when "open"
    open(id)
  when "key"
    key(id)
  else

    keycode = events[ARGV[0]]
    key_event(id, keycode)

  end
end
