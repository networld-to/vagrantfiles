# Vagrantfiles

Different Vagrantfiles (http://www.vagrantup.com/) for local and remote virtual host bootstrapping.

## Setup

If you use the Vagrantfiles of cloud providers you have to install first the
plugins.

    $ vagrant plugin install vagrant-digitalocean
    $ vagrant plugin install vagrant-aws

If there is no script for the startup you have to execute the following commands.

    $ vagrant up --provider=digital_ocean
    $ vagrant up --provider=aws; vagrant plugin install unf

Before you can do that you have to copy the following content to
*~/.vagrant.d/Vagrantfile* to have a global configuration and all your
credentials secured on your localhost. Means: do not push this file to a
remote host, at least not if your credentials are specified directyl in this
file.

      # -*- mode: ruby -*-
      # vi: set ft=ruby :

      ######################################
      # BEGIN: Credentials for Cloud Provder
      ######################################
      ENV['DIGITAL_OCEAN_CLIENT_ID'] = ""
      ENV['DIGITAL_OCEAN_API_KEY'] = ""

      ENV['AWS_ACCESS_KEY'] = ""
      ENV['AWS_SECRET_KEY'] = ""
      ######################################
      # END: Credentials for Cloud Provder
      ######################################

      # Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
      VAGRANTFILE_API_VERSION = "2"

      Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
        config.vm.provider :aws do |aws, override|
          aws.access_key_id        = ENV['AWS_ACCESS_KEY']
          aws.secret_access_key    = ENV['AWS_SECRET_KEY']
          aws.keypair_name         = ENV['USER']

          aws.region               = 'eu-west-1'
          aws.instance_type        = 't1.micro'
          aws.security_groups      = ['default']

          override.ssh.private_key_path = "#{ENV['HOME']}/.ssh/id_rsa"
        end

        config.vm.provider :digital_ocean do |ocean, override|
          ocean.client_id          = ENV['DIGITAL_OCEAN_CLIENT_ID']
          ocean.api_key            = ENV['DIGITAL_OCEAN_API_KEY']
          ocean.ssh_key_name       = ENV['USER']

          ocean.region             = 'Amsterdam 2'
          ocean.size               = '512MB'

          override.ssh.private_key_path = "#{ENV['HOME']}/.ssh/id_rsa"
        end
      end

## Contribute

Want to contribute? Great!

1. Fork it.
2. Create a branch (`git checkout -b my_vagrantfiles`)
3. Commit your changes (`git commit -am "Added Vagrantfile X"`)
4. Push to the branch (`git push origin my_vagrantfiles`)
5. Open a [Pull Request][1]
6. Lean back, relax and wait

[1]: http://github.com/networld-to/vagrantfiles/pulls
