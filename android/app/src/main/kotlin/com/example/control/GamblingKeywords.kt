package com.example.control

object GamblingKeywords {
    private val keywords = listOf(
        "aposta esportiva",
        "apostas esportivas",
        "casa de apostas",
        "casino online",
        "cassino online",
        "jogo do tigrinho",
        "fortune tiger",
        "giro grátis",
        "giro gratis",
        "rodada grátis",
        "rodada gratis",
        "aposta mínima",
        "cotação de odds",
        "bet365",
        "sportingbet",
        "betano",
        "blaze.com",
        "estrelabet",
        "stake.com"
    )

    fun containsGamblingKeyword(text: String?): Boolean {
        if (text.isNullOrBlank()) return false
        val normalized = text.lowercase()
        return keywords.any { normalized.contains(it) }
    }
}