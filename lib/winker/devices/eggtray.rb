module Winker
  module Devices
    module Eggtray
      
      
      def eggs_left
        self.eggs.select{|e| e!=0.0}
      end
      
      def eggs_expired
        eggs_left.select{|e| Time.now>(e.to_time+expire_time)}
      end
      
      def eggs_warning
        eggs_left.select{|e| Time.now>(e.to_time+warning_time)}-eggs_expired
      end
      
      def expire_time
        @obj_data.freshness_period/60/60/24
      end
      
      def warning_time
        expire_time*3/4
      end
      
      def count
        @obj_data.last_reading.inventory
      end
      
      def days_left #days left to first expired egg
        ((@obj_data.last_reading.freshness_remaining - (Time.now.to_i - @obj_data.last_reading.freshness_remaining_updated_at))/60.0/60.0/24).to_i rescue nil
      end
    end
  end
end