# Winker

Winker is a gem written to support the wink api and any other associated platforms.
Currently I only have a wink spotter and ge link light bulbs. If you have other devices that you would like included in the project then there are several options

  1. Fork the project and add your own code.
  2. Ship me your device so i can test with it, then I can ship it back.
  3. Donate a device to me for all my hard work so I can make use of it and test whenever there are api updates.
  
Personally I like option 3 but anything works. Contact me through github to discuss details.

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
      wink.wait_for_updates = true #this is the default setting is optional
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

To temporarily disable or enable blocking use the Winker.wait_for_update block method

examples

    devices = Winker.devices #returns an array of device objects
    devices[1].type
    => "light_bulb"
    
    Winker.wait_for_update(false) do
      devices[1].off
    end
    devices[1].powered? #it takes time for update to reach bulb and signal completion
    => true
    Winker.wait_for_update(true) do
      devices[1].off
    end
    devices[1].powered? #blocks until status updated_at is greater than the time we called the off method
    => false
    
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

#Future plans

1. I need to add more functionality that the api provides as well as more helper methods for devices that I don't have and can't test.
2. I'm getting an Amazon Echo in April that I plan on integrating as a separate gem.
3. I've already started on winker-rails gem that currently works with light bulbs on off and brightness. I'll release it soon and continue to add functionality.


## Contributing

1. Fork it ( https://github.com/kellymahan/winker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
