package com.example.control

object SuspiciousUrls {
    private val domainRegex = Regex(
        """\b[a-z0-9-]+\.(com|net|io|bet|vip|club|app|xyz|site|online|bet\.br|com\.br)\b"""
    )

    // Navegar direto por endereço IP (ex: 153.43.125.132) é raríssimo no
    // uso comum — sites legítimos sempre usam domínio.
    private val rawIpRegex = Regex("""\b(?:\d{1,3}\.){3}\d{1,3}\b""")

    fun containsSuspiciousDomain(text: String?): Boolean {
        if (text.isNullOrBlank()) return false
        val lower = text.lowercase()

        return domainRegex.findAll(lower).any { match ->
            val domainName = match.value.substringBefore(".")
            if (domainName.length < 5) return@any false
            val hasDigit = domainName.any { it.isDigit() }
            val hasLetter = domainName.any { it.isLetter() }
            hasDigit && hasLetter
        }
    }

    fun containsRawIpAddress(text: String?): Boolean {
        if (text.isNullOrBlank()) return false
        return rawIpRegex.containsMatchIn(text)
    }
}