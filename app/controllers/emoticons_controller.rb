class EmoticonsController < ApplicationController
    def index
        emoticons = Emoticon.where_marked_as(:global)

        @emoticons_robots = []
        @emoticons_faces = []

        emoticons.each do |emoticon|
            if emoticon.is_marked_as? :default_robot
                @emoticons_robots.push(emoticon)
            else
                @emoticons_faces.push(emoticon)
            end
        end
    end
end