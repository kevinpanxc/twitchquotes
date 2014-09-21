module StreamUpdater
    def self.update
        streams = Stream.all

        streams.each do |stream|
            begin
                json = TwitchApi.get_twitch_channel_by_name(CGI::escape stream.name)
                stream.followers = json["followers"]
                stream.logo = json["logo"]
                stream.quotes_count = stream.quotes.count
                stream.save
            rescue
                puts "Stream #{stream.name} did not successfully update"
            end
        end
    end
end