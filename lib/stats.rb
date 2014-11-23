module Stats
    @@base = 20
    @@current = @@base

    @@last_updated = DateTime.now

    def self.get_live_users
        now = DateTime.now
        if now.to_time - @@last_updated.to_time > 120
            @@last_updated = now
            delta = @@current - @@base

            if delta > 10
                @@current += Random.rand(-delta..5)
            elsif delta < 10
                @@current += Random.rand(-5..-delta)
            else
                @@current += Random.rand(-10..10)
            end
        end
        @@current = @@current.abs
        @@current
    end
end