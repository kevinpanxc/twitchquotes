class Announcement < ActiveRecord::Base
    # what does setting attr_accessor of a model field do?

    validates :content_unevaluated, presence: true
    # validates :expired, presence: true http://stackoverflow.com/questions/5219150/problem-with-passing-booleans-to-update-attributes

    before_save :perform_string_interpolation

    private
        def perform_string_interpolation
            self.content = eval("\"" + self.content_unevaluated + "\"")
        end

        def asset_path(path)
            ActionController::Base.helpers.asset_path(path)
        end
end