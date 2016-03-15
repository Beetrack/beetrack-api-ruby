#Beetrack API#

The following gem is a Ruby wrapper for the Beetrack API.

##Installation##
```shell
$ gem install beetrackapi
```

##Usage##
###Import###
```ruby
require 'beetrackapi'
```

###Initialize###
```ruby
client = BeetrackAPI::Client.new(:key => <your_api_key>)
```

###Get Routes###
```ruby
client.get_routes(:date => 'dd-mm-yyyy'(Optional))
```

###Create Routes###
```ruby
client.create_route(<route_id>, parameters)
```

###Get Dispatch Information###
```ruby
client.get_dispatch_info(<dispatch_id>)
```

###Update Route Information###
```ruby
client.update_route(route_id, parameters)
```


## Documentation

Please check the API's documentation in https://beetrack.com/apidoc
