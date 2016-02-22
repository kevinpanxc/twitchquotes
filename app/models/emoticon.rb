class Emoticon < ActiveRecord::Base
    include IntegerFlagModule

    @@MarkedAs = {
        none: 0,
        global: 1,
        default_robot: 2,
        faces: 4,
        stream_custom: 8
    }

    def self.get_marked_as
        @@MarkedAs
    end

    def self.add_stream_custom_emote(string_id)
        Emoticon.create!(string_id: string_id, in_use: true, marked_as: get_marked_as[:stream_custom], image_url: "")
    end

    def get_image_url
        if self.is_marked_as? :stream_custom
            return EmoticonUtils.asset_path("emoticons/stream_custom/#{self.string_id.downcase}")
        else
            return self.image_url
        end
    end
end
