class QuotesController < ApplicationController
	def index
		@quotes = Quote.order(created_at: :desc)
	end

	def new
		@quote = Quote.new
	end

	def create
		@quote = Quote.new(quote_params)
		stream = Stream.new(stream_params)

		if Stream.exists?(stream_id: params[:quote][:stream_id])
			save_quote(@quote)
		else
			if stream.save
				save_quote(@quote)
			else
				flash[:error] = "Failed to save stream"
				render 'new'
			end
		end
	end

	private
		def quote_params
			params.require(:quote).permit(:quote, :stream_id)
		end

		def stream_params
			params.permit(:stream_id, :stream_name, :stream_url)
			return_params = ActionController::Parameters.new(stream_id: params[:quote][:stream_id], name: params[:stream_name], url: params[:stream_url] )
			return_params.permit!
		end

		def save_quote(quote)
			if quote.save
				redirect_to quotes_path
			else
				render 'new'
			end
		end
end