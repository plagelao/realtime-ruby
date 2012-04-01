require 'em-websocket'
require 'haml'
require 'rubygems'
require 'sinatra'

EventMachine.run do
  class Demo < Sinatra::Base
    set :root, File.join(File.dirname(__FILE__), '..')

    configure do
      set :app_file, __FILE__
      set :port, ENV['PORT']
    end

    get '/' do
      haml :landing
    end

  end

  EventMachine::WebSocket.start(:host => 'localhost', :port => 8080) do |ws|
    # Websocket code here
      ws.onopen {
          ws.send "connected!!!!"
      }

      ws.onmessage { |msg|
          puts "got message #{msg}"
      }

      ws.onclose   {
          ws.send "WebSocket closed"
      }
  end

  Demo.run!(port: $PORT)
end
