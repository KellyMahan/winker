module Winker
  module Devices
    module DeviceMethods
      #hub must always be last since the hub_id is listed with every device

      VALID_TYPES = %w{
        sensor_pod
        light_bulb
        unknown_device
        hub
      }
  
      WAIT_BLOCK_SLEEP = 1
      WAIT_BLOCK_TIMEOUT = 20.seconds
  
  
      attr_accessor :type, :id, :obj_data, :updated_at
  
      def find_type_and_id
        @type = VALID_TYPES.find{|t| @obj_data.singleton_methods.map(&:to_s).include?("#{t}_id")}
        @id = @obj_data.send("#{@type}_id")
        @updated_at = 2.weeks.ago
      end
  
      def wait_for_update(boolean_proc, options = {}, &block)
        if Winker.wait_for_updates
          options = {
            timeout: WAIT_BLOCK_TIMEOUT
          }.merge(options)
          start = Time.now
          until (success = boolean_proc.call) || Time.now > start+options[:timeout]
            result = yield
            sleep WAIT_BLOCK_SLEEP
          end
          if success
            return result
          else
            raise "Device #{self.type} #{self.name} not updated and timed out after #{options[:timeout]}."
          end
        end
      end
    end
  end
end