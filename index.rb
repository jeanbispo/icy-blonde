require 'em-websocket'

# if ARGV.size != 2
#   $stderr.puts("Usage: ruby index.rb ACCEPTED_DOMAIN PORT")
#   exit(1)
# end

# $stderr.puts("Connected to #{ARGV[0]}:#{ARGV[1]}")
module ChatDemo
  class ChatBackend
    def initialize(app)
      @app = app
    end

    def call(env)
      $stderr.puts(env['SERVER_NAME'], env['SERVER_PORT'])
      EM.run {
        EM::WebSocket.run(:host => env['SERVER_NAME'], :port => env['SERVER_PORT']) do |ws|
          ws.onopen { |handshake|
            puts "WebSocket connection open"

            # Access properties on the EM::WebSocket::Handshake object, e.g.
            # path, query_string, origin, headers

            # Publish message to the client
            ws.send "Hello Client, you connected to server"
          }

          ws.onclose { puts "Connection closed" }

          ws.onmessage { |msg|
            puts "Recieved message: #{msg}"
            ws.send "Pong: #{msg}"
          }
        end
      }
  end
end
end