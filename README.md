# Winker

Winker is a gem written to support the wink api and any other associated platforms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'winker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install winker

## Usage


    Winker.configure do |wink|
      wink.client_id     = "******************"
      wink.client_secret = "******************"
      wink.access_token  = nil
      wink.refresh_token = nil
      wink.username = "email@domain.com"
      wink.password = "**********"
      wink.endpoint = "https://winkapi.quirky.com"
    end

    #retrieve the access_token and refresh_token
    Winker.authorize
    
    #get a list of devices, the hub always seems to be the first device
    devices = Winker.devices
    
    devices.count
    => 8
    
    devices[1].name
    => "Front porch 1"
    
    
#Device Methods/Attributes
Some status methods are blocking in the sense that if a status change is sent, such as powering the device on or off, the next time you call powered? it will refresh every 2 seconds until last updated at time is greater than when the status change was called. If 20 seconds pass before an update then the it throws and error that it hasn't received an update. During my testing an update normally took about 4 seconds. But at times would take much longer.

examples

    devices = Winker.devices #returns an array of device objects
    devices[1].type
    => "light_bulb"
    
Each device has it's own associated type. To make things easier when devices are loaded methods are included to help interact with the device so update(options) doesn't have to be called for every interaction.

##Generic

    refresh
    #This queries the api to update the device status.
    #normally device status is cached unless a status update is called on the device
    #the next time a device status is called a refresh is called first.
    
    update(options)
    #options is a hash with the requested update information
    #all devices make use of this method
    #example for powering on a device
    #update(desired_state: {powered: "true"})
    #for changing a device name
    #update(name: "New Device name")
    #check the api for all updatable information.
    
    type
    #returns the type of device
    
    id
    #returns the id of the device. Used for making api calls for the device
    
    updated_at
    #last time there was an update for the device. Used to tell when a status update has succeeded
    
    #method_missing is also used to access the json data directly from the device query
    #with this you can get other information about the device. Not all devices have the same attributes
    #example attributes:
    
    name
    manufacturer_device_model
    manufacturer_device_id
    device_manufacturer
    model_name
    radio_type
    last_reading
    ....
    

##OnOff < Generic
    on
    #turns a device on, brightness level is preserved
    
    off
    #turns a device off, brightness level is preserved
    
    powered?
    #checks the powered status of the device, *blocking method
    
    on?
    #alias for powered?
    
    off?
    #!powered?

##LightBulb < OnOff
    brightness
    #returns the last brightness level. 0.01 < brightness <= 1
    #even when the device is powered off the last brightness level is returned
    #*blocking method
    
    brightness=
    #sets the brightness level and powers on the device if off

##Sensor Pod < Generic
    temp
    #returns the current temperature in celcius
    #TODO return a temp object that defaults to chosen temp scale
    
    humidity
    #returns the current humidity

#Group Methods
    on
    #turns all devices in the group on
    
    off
    #turns all devices in the group off
    
    brightness=
    #sets the brightness level for all devices in the group.
    #I believe a non dimmable device is simply turned on and brightness is ignored.
    
    members
    #returns an array of all devices include in the group.
    
    #method_missing is also included to retrieve some attributes
    name
    order

#Scene Methods
    activate
    #triggers the scene
    
    members
    #returns an array of all devices include in the group.
    
    settings
    #describes the updates that will occur when triggered
    
    #method_missing is also included to retrieve some attributes
    name
    order    


## Contributing

1. Fork it ( https://github.com/[my-github-username]/winker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
