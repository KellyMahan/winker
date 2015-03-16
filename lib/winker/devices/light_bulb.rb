module Winker
  module Devices
    module LightBulb
      include OnOff

      def updates_finished?
        check_last_brightness
        check_last_powered
        return true
      end
  
      def check_last_brightness
        wait_for_update( Proc.new{@updated_at < @obj_data.last_reading.brightness_updated_at.to_time}) do
          self.refresh
        end
      end

      def self.extended(obj)
  
      end

      def brightness
        check_last_brightness
        @obj_data.last_reading.brightness
      end

      def brightness=(_brightness)
        #set brightness level
        if _brightness == 0
          update(desired_state: {powered: "false", brightness: _brightness})
        else
          update(desired_state: {powered: "true", brightness: _brightness})
        end
      end
    end
  end
end