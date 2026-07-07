/// Representa o progresso do usuário em dias sem recaída.
class StreakModel {
  final DateTime startDate;
  final DateTime? lastRelapseDate;

  StreakModel({
    required this.startDate,
    this.lastRelapseDate,
  });

  /// Data de referência para contar os dias atuais:
  /// se já houve recaída, conta a partir da última recaída.
  DateTime get referenceDate => lastRelapseDate ?? startDate;

  int get currentStreakDays {
    final diff = DateTime.now().difference(referenceDate);
    return diff.inDays;
  }

  /// Marca uma recaída, reiniciando a contagem a partir de hoje.
  StreakModel registerRelapse() {
    return StreakModel(
      startDate: startDate,
      lastRelapseDate: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'startDate': startDate.toIso8601String(),
        'lastRelapseDate': lastRelapseDate?.toIso8601String(),
      };

  factory StreakModel.fromJson(Map<String, dynamic> json) => StreakModel(
        startDate: DateTime.parse(json['startDate']),
        lastRelapseDate: json['lastRelapseDate'] != null
            ? DateTime.parse(json['lastRelapseDate'])
            : null,
      );
}
