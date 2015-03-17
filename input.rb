#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'revdev'
require 'ruinput'
include Revdev
include Ruinput

# 这是我的键盘输入设备 /dev/input/event1
input_device = EventDevice.new('/dev/input/event1')
uinput = UinputDevice.new

begin
  input_device.grab
rescue IOError
  puts("IOError when grabbing device.")
  exit 1
else
  loop do
    # 这里的 select 调用有什么用途? 是否可以省略?
    # IO.select([input_device], [], [])
    while event = input_device.read_input_event
      on_event(event) if event.type == EV_KEY
    end
  end
ensure
  input_device.ungrab()
end

# stub on_event(message) 方法.
def on_event(message)
  print "#{message}"
  raise 'exit!'
end

loop(select_device)
