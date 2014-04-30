class StreamsController < ApplicationController
	def index
		if params[:letter] =~ /[[:alpha:]]/
			@streams = Stream.where("UPPER(name) LIKE :prefix", prefix: "#{params[:letter]}%")
			@letter = params[:letter].upcase
		elsif params[:page] =~ /^\d+$/
			@streams = Stream.paginate(page: params[:page], :per_page => 15, order: "quotes_count DESC")
		else
			@streams = Stream.where("UPPER(name) LIKE :prefix", prefix: "A%")
			@letter = "A"
		end
	end

	def show
		@quote_dom_id = 0
		@stream = Stream.where('LOWER(name) = ?', params[:id].downcase).first
		if @stream
			@quotes = @stream.quotes.paginate(page: params[:page], :per_page => 10, order: "created_at DESC")
		else
			render 'show_missing'
		end
	end

 	def search
		if params[:search]
			@streams = TwitchApi.search_twitch_channels(params[:search])
		elsif
			@streams = Array.new
		end

		respond_to do |format|
        	format.js
		end
	end
end