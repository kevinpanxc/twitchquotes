module StreamUpdater
    def self.update
        streams = Stream.all

        streams.each do |stream|
            json = TwitchApi.get_twitch_channel_by_name(CGI::escape stream.name)
            stream.followers = json["followers"]
            stream.logo = json["logo"]
            stream.quotes_count = stream.quotes.count
            stream.save
        end
    end
end