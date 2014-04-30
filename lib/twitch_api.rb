require "net/http"

module TwitchApi
    GET_CHANNEL_BY_NAME = "https://api.twitch.tv/kraken/channels/"
    CHANNEL_SEARCH = "https://api.twitch.tv/kraken/search/channels?"

    def self.get_twitch_channel_by_name (stream_name)
        get_json_response_and_parse(GET_CHANNEL_BY_NAME + stream_name)
    end

    def self.get_json_response_and_parse (uri)
        uri = URI.parse(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
        response = http.get(uri.request_uri)
        return ActiveSupport::JSON.decode(response.body)
    end

    def self.search_twitch_channels (search_string)
        query_params = { q: search_string }.to_query
        parsed_json = get_json_response_and_parse(CHANNEL_SEARCH + query_params)
        parsed_json["channels"]        
    end
end