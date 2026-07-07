package com.example.control

/**
 * Lista de pacotes (apps) monitorados pelo Control.
 * Adicione aqui o "applicationId" de cada app de aposta que deve ser bloqueado.
 * Você pode descobrir o packageName de um app instalado rodando, com o
 * celular conectado:
 *   adb shell pm list packages | findstr <parte do nome>
 */
object BlockedApps {
    val packages = setOf(
        "com.kaizengaming.betano.brazil"
        // Adicione mais conforme for testando com apps reais instalados.
    )

    fun isBlocked(packageName: String?): Boolean {
        if (packageName == null) return false
        return packages.contains(packageName)
    }
}
