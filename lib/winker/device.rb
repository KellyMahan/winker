
require 'winker/devices/device_methods'
require 'winker/devices/generic_device'
require 'winker/devices/on_off'
require 'winker/devices/light_bulb'
require 'winker/devices/sensor_pod'
require 'winker/devices/unknown_device'
require 'winker/devices/hub'

module Winker
  class Device
    def self.load_devices(data)
      data.map{|d| Winker::Device.new(d)}
    end
    
    def initialize(obj_data)
      @obj_data = obj_data
      find_type_and_id
      self.extend(eval("Winker::Devices::#{@type.classify}"))
    end
  
    def method_missing(method_sym, *arguments, &block)
      if obj_data.respond_to?(method_sym)
        obj_data.send(method_sym, *arguments, &block)
      else
        super
      end
    end
    
    include Winker::Devices::DeviceMethods
    include Winker::Devices::GenericDevice
    include Winker::Devices::OnOff
    include Winker::Devices::LightBulb
    include Winker::Devices::SensorPod
    include Winker::Devices::UnknownDevice
    include Winker::Devices::Hub
    # VALID_TYPES=%w{
    #   sensor_pod
    #   light_bulb
    #   garage_door
    #   binary_switch
    #   air_conditioner
    #   propane_tank
    #   outlet
    #   powerstrip
    #   piggy_bank
    #   eggtray
    #   cloud_clock
    #   alarm
    #   dial
    #   scene
    #   robot
    #   group
    # }
    
  end
end