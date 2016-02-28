require "commander"

module Dovpn
  class App
    include Commander::Methods

    def run
      program :name, 'dovpn'
      program :version, '0.0.1'
      program :description, 'Set up an OpenVPN server on DigitalOcean on demand.'

      command :start do |c|
        c.syntax = 'dovpn start [options]'
        c.summary = ''
        c.description = ''
        c.example 'description', 'command example'
        c.option '--some-switch', 'Some switch that does something'
        c.action do |args, options|
          # Do something or c.when_called Dovpn::Commands::Start
        end
      end

      command :stop do |c|
        c.syntax = 'dovpn stop [options]'
        c.summary = ''
        c.description = ''
        c.example 'description', 'command example'
        c.option '--some-switch', 'Some switch that does something'
        c.action do |args, options|
          # Do something or c.when_called Dovpn::Commands::Stop
        end
      end

      command :status do |c|
        c.syntax = 'dovpn status [options]'
        c.summary = ''
        c.description = ''
        c.example 'description', 'command example'
        c.option '--some-switch', 'Some switch that does something'
        c.action do |args, options|
          # Do something or c.when_called Dovpn::Commands::Status
        end
      end

      run!
    end
  end
end
