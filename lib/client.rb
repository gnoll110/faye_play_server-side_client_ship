require 'faye'
server = Faye::RackAdapter.new(:mount => '/push', :timeout => 45)
# Add some extensions ...
    
EM.run {
  thin = Rack::Handler.get('thin')
  thin.run(server, :Port => 8000)
      
  #server.get_client.subscribe('/ping') do |message|
  #  puts '>>'+message.inspect
  #end

  server.bind(:subscribe) do |client_id, channel|
    puts "[  SUBSCRIBE] #{client_id} -> #{channel}"
  end

  server.bind(:unsubscribe) do |client_id, channel|
    puts "[UNSUBSCRIBE] #{client_id} -> #{channel}"
  end

  server.bind(:disconnect) do |client_id|
    puts "[ DISCONNECT] #{client_id}"
  end
}
