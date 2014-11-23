module Stats
    @@b = 20
    @@c = @@b

    @@l_u = DateTime.now

    def self.get_live_users
        x
    end

    def self.x
        n = DateTime.now
        if n.to_time - @@l_u.to_time > 180
            @@l_u = n
            d = @@c - @@b

            if d > 10
                @@c += Random.rand(-d..5)
            elsif d < -10
                @@c += Random.rand(-5..-d)
            else
                @@c += Random.rand(-10..10)
            end
        end
        @@c = @@c.abs
        @@c
    end
end