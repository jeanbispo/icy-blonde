require 'em-websocket'

if ARGV.size != 2
  $stderr.puts("Usage: ruby index.rb ACCEPTED_DOMAIN PORT")
  exit(1)
end

$stderr.puts("Connected to #{ARGV[0]}:#{ARGV[1]}")

EM.run {
  EM::WebSocket.run(:host => ARGV[0], :port => 80) do |ws|
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