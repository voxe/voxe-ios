# This file is automatically generated. Do not edit.

if Object.const_defined?('TestFlight') and !UIDevice.currentDevice.model.include?('Simulator')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidBecomeActiveNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
  
  TestFlight.takeOff('fdbf9ae8-14a7-43d1-9d59-42bd5fa609b4')
  end)
end