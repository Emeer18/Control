/// Tipos de registro que o usuário pode fazer no diário.
enum JournalEntryType {
  urge, // sentiu vontade, mas resistiu
  relapse, // recaída de fato
  reflection, // reflexão livre / vitória
}

class JournalEntry {
  final String id;
  final DateTime date;
  final JournalEntryType type;
  final String note;
  final int? intensityLevel; // 1 a 5, o quão forte foi a vontade

  JournalEntry({
    required this.id,
    required this.date,
    required this.type,
    required this.note,
    this.intensityLevel,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'type': type.name,
        'note': note,
        'intensityLevel': intensityLevel,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        id: json['id'],
        date: DateTime.parse(json['date']),
        type: JournalEntryType.values.byName(json['type']),
        note: json['note'],
        intensityLevel: json['intensityLevel'],
      );
}
