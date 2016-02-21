class SubmissionsController < ApplicationController
    def new
        @submission = Submission.new
    end

    def create
        @submission = Submission.new(submission_params)

        if current_ip_user.last_day.nil?
            current_ip_user.last_day = DateTime.now
            current_ip_user.recent_submissions_count = 1
        else
            if current_ip_user.last_day > 1.day.ago
                if current_ip_user.recent_submissions_count >= IpUser::MAX_SUBMISSIONS_PER_DAY
                    flash[:error] = "Sorry, you've used up all #{IpUser::MAX_SUBMISSIONS_PER_DAY} of your submissions for the day!"
                    redirect_to quotes_path
                    return
                else
                    current_ip_user.recent_submissions_count += 1
                end
            else
                current_ip_user.last_day = DateTime.now
                current_ip_user.recent_submissions_count = 1
            end
        end

        @submission.ip_user = current_ip_user

        begin
            ActiveRecord::Base.transaction do
                @submission.save!
                current_ip_user.save!
            end
            flash[:success] = "Thanks for submitting, you have #{IpUser::MAX_SUBMISSIONS_PER_DAY - current_ip_user.recent_submissions_count} submissions left for the day!"
            redirect_to quotes_path
        rescue ActiveRecord::RecordInvalid => invalid
            if @submission.errors.messages.length == 0
                flash[:error] = "Something went wrong on the server!"
            end
            render 'new'
        end
    end

    private
        def submission_params
            create_current_ip_user if current_ip_user.nil?

            params.require(:submission).permit(:quote)
        end
end