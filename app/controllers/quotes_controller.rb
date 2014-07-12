class QuotesController < ApplicationController	
	def index
		@quote_dom_id = 0
		@quotes = Quote.paginate(page: params[:page], :per_page => 10, order: "created_at DESC")
	end

	def new
		@quote = Quote.new
	end

	def show
		@quote_dom_id = 0
		@quote = Quote.find(params[:id])
	end

	def create
		@quote = Quote.new(quote_params)
		@stream = Stream.new(stream_params)

		if Stream.exists?(stream_id: params[:quote][:stream_id])
			save_quote(@quote)
		else
			if @stream.save
				save_quote(@quote)
			else
				flash.now[:error] = "Failed to save stream"
				render 'new'
			end
		end
	end

	def destroy
		@quote = Quote.find(params[:id])
		@quote.stream.quotes_count = @quote.stream.quotes.count
		@quote.delete
		redirect_to quotes_path
	end

	private
		def quote_params
			params.require(:quote).permit(:quote, :stream_id, :title)
		end

		def stream_params
			params.permit(:stream_id, :stream_name, :stream_url)
			return_params = ActionController::Parameters.new(stream_id: params[:quote][:stream_id], 
				name: params[:stream_name], 
				url: params[:stream_url],
				logo: params[:stream_logo],
				followers: params[:stream_followers] )
			return_params.permit!
		end

		def save_quote(quote)
			if quote.save
				quote.stream.quotes_count = quote.stream.quotes.count
				quote.stream.save
				redirect_to quotes_path
			else
				render 'new'
			end
		end
end