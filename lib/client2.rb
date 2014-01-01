EM.run do
  client = Faye::Client.new('http://localhost:9292/faye')
  publication = client.publish("/faye/new_chats", {
      "user" => "ruby-logger",
      "message" => "Got your message!"
  })
  publication.callback do
    puts "[PUBLISH SUCCEEDED]"
  end
  publication.errback do |error|
    puts "[PUBLISH FAILED] #{error.inspect}"
  end
end
