Abstract models
===============

Models can inherit from other models without having to deal with the database. You use an abstract model in this case.

    class AbstractModel < ActiveRecord::Base
        self.abstract_class = true
    end

    class Emoticon < AbstractModel
    end

HTML style tags in body
=======================

In HTML5 you can have style tags in the body. Otherwise it's invalid code.