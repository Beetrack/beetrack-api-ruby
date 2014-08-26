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
client.getroutes(:date => 'dd-mm-yyyy'(Optional))
```

###Create Routes###
```ruby
client.createroute(<route_id>, parameters (As seen in beetrack.in/external_api.html))
```

###Get Dispatch Information###
```ruby
client.getdispatchinfo(<dispatch_id>)
```