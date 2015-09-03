module Misc
    def self.distribute_f_ip_likes (quotes)
        quotes.each do |quote|
            quote.generate_f_ip_likes
            quote.save
        end
    end

    def self.adjust_f_ip_likes (quotes)
        results = []
        Quote.transaction do
            quotes.each do |quote|
                l_to_a = 0

                # adjust based on difference
                delta = (quote.ip_likes.count * quote.ip_likes.count) - quote.f_ip_likes
                if delta > 0
                    l_to_a += Math.sqrt(delta).ceil
                end

                # random chance
                r = rand(1..20)
                if r == 10
                    l_to_a += 1
                end

                # finish
                quote.f_ip_likes += l_to_a
                quote.save

                if l_to_a > 0
                    results.push("[#{quote.id} : #{l_to_a}]")
                end
            end
        end
        puts results.join(",")
    end
end