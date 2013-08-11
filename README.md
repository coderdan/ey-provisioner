# Ey::Provisioner

[![Build Status](https://api.travis-ci.org/coderdan/ey-provisioner.png)](https://travis-ci.org/coderdan/ey-provisioner)
[![Code Climate](https://codeclimate.com/github/coderdan/ey-provisioner.png)](https://codeclimate.com/github/coderdan/ey-provisioner)

The EY Provisioner is a Ruby based client gem for interacting with the [EngineYard](http://www.engineyard.com) Instance Provisioning V2 API.
See [this blog post](https://support.cloud.engineyard.com/entries/22498973-use-the-instance-provisioning-api-with-engine-yard-cloud "Engine Yard Instance Provisioning")

## Installation

Add this line to your application's Gemfile:

    gem 'ey-provisioner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ey-provisioner

## Usage

To use the ey-provisioner start by creating a connection:

    connection = Ey::Provisioner::Connection.new(token)

Via the connection, you get the relevant environment:

    env = connection.environment(1234)

On the connection you can now add or remove instances:

    env.add_instance(:name => "my-instance", :role => "util", :instance_size => 'xlarge')
    env.remove_instances(:role => "util") # Will shutdown all util servers

### Getting your token

See [the EY docs](https://support.cloud.engineyard.com/entries/22498973-use-the-instance-provisioning-api-with-engine-yard-cloud "Engine Yard Instance Provisioning") for instructions on how to get your token.

### Getting the environment ID

Within the EngineYard interface, click on the deployment history link within the Environment. The page's URL will be of the form .../environments/x/deployments. X will be the environment ID.

## Limitations

The Gem does not currently support retrieving provisioning status nor does it allow you to list all environments for the account.

## Documentation

Full documentation can be found [here](http://rubydoc.info/github/coderdan/ey-provisioner/master/frames).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
