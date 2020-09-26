require 'em-websocket'

if ARGV.size != 2
  $stderr.puts("Usage: ruby index.rb ACCEPTED_DOMAIN PORT")
  exit(1)
end


EM.run {
  EM::WebSocket.run(:host => ARGV[0], :port => ARGV[1]) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      ws.send "Pong: #{msg}"
    }
  end
}