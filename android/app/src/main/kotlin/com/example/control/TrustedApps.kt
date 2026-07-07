package com.example.control

object TrustedApps {
    private val packages = setOf(
        // --- Componentes de sistema (NUNCA remover estes) ---
        "com.mi.android.globallauncher",
        "com.miui.home",
        "com.android.launcher3",
        "com.google.android.apps.nexuslauncher",
        "com.android.systemui",
        "com.google.android.inputmethod.latin",
        "com.touchtype.swiftkey",
        "com.samsung.android.honeyboard",
        "com.miui.securitycenter",

        // --- Redes sociais e apps comuns ---
        "com.instagram.android",
        "com.whatsapp",
        "com.google.android.youtube",
        "com.zhiliaoapp.musically",
        "com.facebook.katana",
        "com.facebook.orca",
        "com.twitter.android",
        "com.spotify.music",
        "com.google.android.gm",
        "com.google.android.apps.maps",
        "com.android.vending"
    )

    fun isTrusted(packageName: String?): Boolean {
        if (packageName == null) return false
        return packages.contains(packageName)
    }
}