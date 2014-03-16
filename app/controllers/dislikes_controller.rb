class DislikesController < ApplicationController
    before_filter :require_facebook_sign_in
    before_filter :setup

    def create
        @dislike = Dislike.new(dislike_params)

        if !remove_like && @dislike.save
            respond_to do |format|
                format.js
            end
        else
            render 'general/server_error'
        end
    end

    def destroy
        dislike = Dislike.find(params[:id])
        dislike.destroy

        if !Dislike.exists?(params[:id])
            respond_to do |format|
                format.js
            end
        else
            render 'general/server_error'
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

        def setup
            @quote = Quote.find(params[:quote_id])
            @quote_dom_id = params[:quote_dom_id]
        end

        def remove_like
            @remove_like = false

            like_to_remove = current_facebook_user.likes.find_by(quote_id: params[:quote_id])

            if like_to_remove
                @remove_like = true
                like_to_remove.destroy
            end

            current_facebook_user.likes.find_by(quote_id: params[:quote_id])
        end
end