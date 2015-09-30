class Emoticon < ActiveRecord::Base
    include IntegerFlagModule

    @@MarkedAs = {
        none: 0,
        global: 1,
        default_robot: 2,
        faces: 4
    }

    def self.get_marked_as
        @@MarkedAs
    end
end
