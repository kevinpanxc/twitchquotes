module IntegerFlagModule
    extend ActiveSupport::Concern

    def self.included base
        base.extend ClassMethods
    end

    module ClassMethods
        def where_marked_as(type)
            where("marked_as & ? = ?", get_marked_as[type], get_marked_as[type])
        end
    end

    def set_marked_as(type)
        if self.class.get_marked_as.has_key? type
            self.marked_as |= self.class.get_marked_as[type]
        end
    end

    def remove_marked_as(type)
        if self.class.get_marked_as.has_key? type
            self.marked_as &= ~self.class.get_marked_as[type]
        end
    end

    def is_marked_as?(type)
        if self.class.get_marked_as.has_key? type
            return self.marked_as & self.class.get_marked_as[type] != 0
        else
            return false
        end
    end

    def not_marked_as?
        return self.marked_as == 0
    end
end