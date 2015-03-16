module Winker
  module Devices
    module OnOff
      def updates_finished?
        check_last_powered
        return true
      end
  
      def check_last_powered
        wait_for_update( Proc.new{@updated_at < @obj_data.last_reading.powered_updated_at.to_time}) do
          self.refresh
        end
      end

      def powered?
        check_last_powered
        @obj_data.last_reading.powered
      end

      def on
        #turn on device
        update(desired_state: {powered: "true"})
      end

      def off
        #turn off device
        update(desired_state: {powered: "false"})
      end

      def off?
        !powered?
      end

      alias on? powered?
    end
  end
end