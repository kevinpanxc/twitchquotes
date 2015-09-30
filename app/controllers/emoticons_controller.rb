class EmoticonsController < ApplicationController
    def index
        emoticons = Emoticon.where_marked_as(:global)

        @emoticons_robots = []
        @emoticons_faces = []

        emoticons.each do |x|
            if x.marked_as & 2 == 2
                @emoticons_robots.push(x)
            else
                @emoticons_faces.push(x)
            end
        end
    end
end