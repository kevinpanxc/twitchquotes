class LikesController < ApplicationController
    before_filter :require_facebook_sign_in

    def create
        @quote = Quote.find(params[:quote_id])
        @quote_dom_id = params[:quote_dom_id]

        dislike_to_remove = current_facebook_user.dislikes.find_by(quote_id: params[:quote_id])

        @remove_dislike = false

        if dislike_to_remove
            @remove_dislike = true

            dislike_to_remove.destroy
        end

        @like = Like.new(like_params)
        @like.save

        respond_to do |format|
            format.js
        end
    end

    def destroy
        like = Like.find(params[:id])
        like.destroy

        @quote = Quote.find(params[:quote_id])
        @quote_dom_id = params[:quote_dom_id]

        respond_to do |format|
            format.js
        end
    end

    private
        def like_params
            return_params = ActionController::Parameters.new(
                quote_id: params[:quote_id],
                facebook_user_id: current_facebook_user.id
            )

            return_params.permit!
        end
end