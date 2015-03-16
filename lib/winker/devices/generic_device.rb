module Winker
  module Devices
    module GenericDevice
      def refresh
        @obj_data = Winker.get_device(@type, @id)
      end

      def update(options)
        @updated_at = Time.now + Winker.server_time_dif
        Winker.update_device(@type, @id, options)
      end
    end
  end
end