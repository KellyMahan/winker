module Winker
  module ApiMethods
    def get(path, params = nil)
      response = super
      @server_time_dif = Time.parse(response.headers["date"]) - Time.now
      return response
    end
  
    def put(path, params = nil)
      response = super
      @server_time_dif = Time.parse(response.headers["date"]) - Time.now
      return response
    end
  
    def post(path, params = nil)
      response = super
      @server_time_dif = Time.parse(response.headers["date"]) - Time.now
      return response
    end
  
    def authorize
      response = post("/oauth2/token", {client_id: Winker.client_id, client_secret: Winker.client_secret, username: Winker.username, password: Winker.password, grant_type: "password"})
      @access_token = response.body["access_token"]
      @refresh_token = response.body["refresh_token"]
      @connection = nil
      response
    end
  
    def devices
    
      response = get("/users/me/wink_devices")
      Winker::Device.load_devices(parse(response.body).data)
    end
  
    def groups
      response = get("/users/me/groups")
      Winker::Group.load_groups(parse(response.body).data)
    end
  
    def icons
      response = get("/icons")
      parse(response.body).data
    end
  
    def channels
      response = get("/channels")
      parse(response.body).data
    end
  
    def scenes
      response = get("/users/me/scenes")
      Winker::Scene.load_scenes(parse(response.body).data)
    end
  
    def get_scene(scene_id)
      response = get("/scenes/#{scene_id}")
      parse(response.body).data
    end
  
    # def update_scene(scene_id, options)
    #   response = put("/scenes/#{scene_id}")
    #   parse(response.body).data
    # end
  
    def activate_scene(scene_id)
      response = post("/scenes/#{scene_id}/activate")
      parse(response.body).data
    end
  
    def get_device(type, id)
      response = get("/#{type}s/#{id}")
      parse(response.body).data
    end
  
    def update_device(type, id, options)
      response = put("/#{type}s/#{id}", options)
      parse(response.body).data
    end
  
    def update_group(id, options)
      response = post("/groups/#{id}/activate", options)
      parse(response.body).data
    end
  
  end
end