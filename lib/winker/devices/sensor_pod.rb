module Winker
  module Devices
    module SensorPod

      def self.extended(obj)
  
      end

      def temp
        @obj_data.last_reading.temperature
      end

      def humidity
        @obj_data.last_reading.humidity
      end

    end
  end
end