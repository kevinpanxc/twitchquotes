module Misc
    def self.distribute_f_ip_likes (quotes)
        quotes.each do |quote|
            quote.generate_f_ip_likes
            quote.save
        end
    end
end