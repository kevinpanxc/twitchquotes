class ErrorsController < ApplicationController
    def error_404
        @status = 404
        render 'error_page', status: 404
    end

    def error_422
        @status = 422
        render 'error_page', status: 422
    end

    def error_500
        @status = 500
        render 'error_page', status: 500
    end
end
