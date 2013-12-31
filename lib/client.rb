require 'faye'
server = Faye::RackAdapter.new(:mount => '/push', :timeout => 45)
# Add some extensions ...
    
EM.run {
  thin = Rack::Handler.get('thin')
  thin.run(server, :Port => 8000)
      
  server.get_client.subscribe('/ping') do |message|
    puts message.inspect
  end
}
