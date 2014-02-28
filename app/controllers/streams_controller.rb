class StreamsController < ApplicationController
	@@twitchChannelSearchURL = "https://api.twitch.tv/kraken/search/channels?q="

	def index
		@streams = Stream.all
	end

	def show
		@stream = Stream.find_by name: params[:id]
		if @stream
			@quotes = @stream.quotes
		else
			render 'show_missing'
		end
	end

 	def search
 		require "net/http"
		twitchChannelSearch

		respond_to do |format|
        	format.js
		end
	end

	def twitchChannelSearch
		if params[:search]
			processedJson = getResponseAndJSONDecode(@@twitchChannelSearchURL + params[:search])
			@streams = processedJson["channels"]
		elsif
			@streams = Array.new
		end
	end

	def getResponseAndJSONDecode (uriString)
		uri = URI.parse(uriString)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
		response = http.get(uri.request_uri)
		return ActiveSupport::JSON.decode(response.body)
	end
end