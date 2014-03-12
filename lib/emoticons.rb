class Emoticons
    def self.emoticons
        @@emoticons
    end

    @@emoticons = {
        Kappa: ActionController::Base.helpers.asset_path("emoticons/kappa.png"),
        PJSalt: ActionController::Base.helpers.asset_path("emoticons/pjsalt.png"),
        BrainSlug: ActionController::Base.helpers.asset_path("emoticons/brainslug.png"),
        FrankerZ: ActionController::Base.helpers.asset_path("emoticons/frankerz.png"),
        Keepo: ActionController::Base.helpers.asset_path("emoticons/keepo.png"),
        Kreygasm: ActionController::Base.helpers.asset_path("emoticons/kreygasm.png"),
        FailFish: ActionController::Base.helpers.asset_path("emoticons/failfish.png")
    }
end