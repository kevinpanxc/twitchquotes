class LikesController < ApplicationController
    before_filter :require_facebook_sign_in
    before_filter :setup

    def create
        @like = Like.new(like_params)

        if !remove_dislike && @like.save
            respond_to do |format|
                format.js
            end
        else
            render 'general/server_error'
        end
    end

    def destroy
        like = Like.find(params[:id])
        like.destroy

        if !Like.exists?(params[:id])
            respond_to do |format|
                format.js
            end
        else
            render 'general/server_error'
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

        def setup
            @quote = Quote.find(params[:quote_id])
            @quote_dom_id = params[:quote_dom_id]
        end

        def remove_dislike
            @remove_dislike = false

            dislike_to_remove = current_facebook_user.dislikes.find_by(quote_id: params[:quote_id])

            if dislike_to_remove
                @remove_dislike = true
                dislike_to_remove.destroy
            end

            current_facebook_user.dislikes.find_by(quote_id: params[:quote_id])
        end
end