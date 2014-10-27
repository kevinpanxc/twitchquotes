class QuotesController < ApplicationController
    before_filter :signed_in_user, only: [:edit, :update, :marked]
    before_filter :is_admin, only: [:marked]

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

    def edit
        @quote = Quote.find(params[:id])
    end

    def update
        @quote = Quote.find(params[:id])
        if @quote.update_attributes(quote_params)
            redirect_to @quote
        else
            render 'edit'
        end
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

    def search
        @quote_dom_id = 0
        @search_type = "title"
        @query = ""
        if params[:search_type] == "quote"
            @quotes = Quote.where("lower(quote) like ?", "%#{params[:query].downcase}%").paginate(page: params[:page], :per_page => 20, order: "created_at DESC")
        else
            @quotes = Quote.where("lower(title) like ?", "%#{params[:query].downcase}%").paginate(page: params[:page], :per_page => 20, order: "created_at DESC")
        end
        @search_type = params[:search_type] if params.has_key? :search_type
        @query = params[:query] if params.has_key? :query
        render 'search_results'
    end

    def destroy
        @quote = Quote.find(params[:id])
        @quote.stream.quotes_count = @quote.stream.quotes.count
        @quote.delete
        redirect_to quotes_path
    end

    def show_marked_quote
        unless Quote.exists?(params[:id]) and params.has_key? :dom_id
            render 'general/server_error'
        else
            @quote = Quote.find(params[:id])
            @quote_dom_id = params[:dom_id]
            respond_to do |format|
                format.js
            end
        end
    end

    def marked
        @quotes = Quote.where.not( marked_as: nil ).paginate(page: params[:page], :per_page => 20, order: "created_at DESC")
        render 'marked_quotes'
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