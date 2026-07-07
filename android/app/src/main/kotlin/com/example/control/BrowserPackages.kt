package com.example.control

object BrowserPackages {
    private val packages = setOf(
        "com.android.chrome",
        "com.brave.browser",
        "org.mozilla.firefox",
        "com.opera.browser",
        "com.opera.mini.native",
        "com.sec.android.app.sbrowser",
        "com.microsoft.emmx",
        "com.mi.globalbrowser"
    )

    fun isBrowser(packageName: String?): Boolean {
        if (packageName == null) return false
        return packages.contains(packageName)
    }
}