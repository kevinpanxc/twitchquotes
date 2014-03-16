class Emoticons
    def self.emoticons
        @@emoticons
    end

    def self.asset_path(path)
        ActionController::Base.helpers.asset_path(path)
    end

    @@emoticons = {
        Kappa: asset_path("emoticons/kappa.png"),
        PJSalt: asset_path("emoticons/pjsalt.png"),
        BrainSlug: asset_path("emoticons/brainslug.png"),
        FrankerZ: asset_path("emoticons/frankerz.png"),
        Keepo: asset_path("emoticons/keepo.png"),
        Kreygasm: asset_path("emoticons/kreygasm.png"),
        FailFish: asset_path("emoticons/failfish.png"),
        BibleThump: asset_path("emoticons/biblethump.png")
    }
end