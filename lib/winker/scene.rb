module Winker

  class Scene
    
    attr_accessor :type, :id, :obj_data
    
    def self.load_scenes(data)
      data.map{|s| Winker::Scene.new(s)}
    end
    
    def initialize(obj_data)
      @obj_data = obj_data
      @id = @obj_data.scene_id
    end
    
    def members
      devices.select{|d| @obj_data.members.map{|m| m[:object_id]}.include?(d.id)}
    end
    
    def settings
      @obj_data.members
    end
    
    def activate
      Winker.activate_scene(self.id)
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