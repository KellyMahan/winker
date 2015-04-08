module Winker
    
  class Group
    
    attr_accessor :type, :id, :obj_data
    
    def self.load_groups(data)
      data.map{|d| Winker::Group.new(d)}
    end
    
    def initialize(obj_data)
      @obj_data = obj_data
      @id = @obj_data.group_id
    end
    
    def members
      devices.select{|d| @obj_data.members.map{|m| m[:object_id]}.include?(d.id)}
    end
    
    def on
      Winker.update_group(@id, {desired_state: {powered: true}})
    end
    
    def off
      Winker.update_group(@id, {desired_state: {powered: false}})
    end
    
    def update(options)
      @updated_at = Time.now + Winker.server_time_dif
      Winker.update_group(@id, options)
    end
    
    def brightness=(_brightness)
      #set brightness level
      Winker.update_group(@id, {desired_state: {powered: true, brightness: _brightness}})
    end
  
    def method_missing(method_sym, *arguments, &block)
      
      if obj_data.respond_to?(method_sym)
        obj_data.send(method_sym, *arguments, &block)
      else
        super
      end
    end
    
    private

    
    def devices
      @devices ||= Winker.devices
    end
    
  end
end