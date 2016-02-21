class Submission < ActiveRecord::Base
    belongs_to :ip_user

    validates :quote, presence: true, length: { maximum: 1200 }

    before_save :process_emoticons

    private
        def process_emoticons
            self.quote.strip!
            self.quote = EmoticonUtils.revert_img_tag_to_emoticon_string(self.quote)
            self.quote = EmoticonUtils.emoticon_string_to_img_tag(self.quote)
        end
end