class DislikesController < ApplicationController
    def create
        @quote = Quote.find(params[:quote_id])
        @quote_dom_id = params[:quote_dom_id]

        like_to_remove = current_facebook_user.likes.find_by(quote_id: params[:quote_id])

        @remove_like = false

        if like_to_remove
            @remove_like = true
            like_to_remove.destroy
        end

        @dislike = Dislike.new(dislike_params)
        @dislike.save

        respond_to do |format|
            format.js
        end
    end

    def destroy
        dislike = Dislike.find(params[:id])
        dislike.destroy

        @quote = Quote.find(params[:quote_id])
        @quote_dom_id = params[:quote_dom_id]

        respond_to do |format|
            format.js
        end
    end

    private
        def dislike_params
            return_params = ActionController::Parameters.new(
                quote_id: params[:quote_id],
                facebook_user_id: current_facebook_user.id
            )

            return_params.permit!
        end
end