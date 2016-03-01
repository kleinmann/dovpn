require "commander"
require "yaml"
require "droplet_kit"
require "open-uri"

module Dovpn
  class App
    include Commander::Methods

    def run
      program :name, 'dovpn'
      program :version, Dovpn::VERSION
      program :description, 'Set up an OpenVPN server on DigitalOcean on demand.'

      config = YAML.load(File.read(File.join(ENV["HOME"], ".dovpn.yml"))) || Hash.new("")

      command :start do |c|
        c.syntax = 'dovpn start [options]'
        c.summary = ''
        c.description = ''
        c.option '--token TOKEN', String, 'DigitalOcean API Token'
        c.action do |args, options|
          options.default token: config["token"]

          unless config["id"]
            client = DropletKit::Client.new(access_token: options.token)
            user_data = open("https://raw.githubusercontent.com/digitalocean/do_user_scripts/673d1a0b97c4c5306dd6432c90cc8c6fcb05860f/Ubuntu-14.04/network/open-vpn.yml").read
            droplet = DropletKit::Droplet.new(name: 'dovpn', region: 'nyc2', image: 'ubuntu-14-04-x64', size: '512mb', user_data: user_data)
            created = client.droplets.create(droplet)

            config["id"] = created["id"]
          end
        end
      end

      command :stop do |c|
        c.syntax = 'dovpn stop [options]'
        c.summary = ''
        c.description = ''
        c.option '--token TOKEN', String, 'DigitalOcean API Token'
        c.action do |args, options|
          options.default token: config["token"]

          if config["id"]
            client = DropletKit::Client.new(access_token: options.token)
            droplet = client.droplets.delete(id: config["id"])
            config.delete("id")
          end
        end
      end

      command :status do |c|
        c.syntax = 'dovpn status [options]'
        c.summary = ''
        c.description = ''
        c.action do |args, options|
          if config["id"]
            puts "VPN online"
          else
            puts "VPN offline"
          end
        end
      end

      run!

      File.write(File.join(ENV["HOME"], ".dovpn.yml"), config.to_yaml)
    end
  end
end
