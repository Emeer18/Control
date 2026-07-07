import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  // TODO: substituir por dado persistido (SharedPreferences / banco local)
  final List<JournalEntry> _entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diário')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntrySheet,
        backgroundColor: AppColors.deepBlue,
        child: const Icon(Icons.add),
      ),
      body: _entries.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _buildEntryCard(_entries[index]),
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'Nenhum registro ainda.\nToque no + para anotar como você está se sentindo.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.5),
        ),
      ),
    );
  }

  Widget _buildEntryCard(JournalEntry entry) {
    final config = _typeConfig(entry.type);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(config.icon, color: config.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(config.label,
                      style: TextStyle(fontWeight: FontWeight.w600, color: config.color)),
                  const SizedBox(height: 4),
                  Text(entry.note, style: const TextStyle(color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Text(
                    _formatDate(entry.date),
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEntrySheet() {
    final noteController = TextEditingController();
    JournalEntryType selectedType = JournalEntryType.urge;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Novo registro',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: JournalEntryType.values.map((type) {
                      final config = _typeConfig(type);
                      final isSelected = type == selectedType;
                      return ChoiceChip(
                        label: Text(config.label),
                        selected: isSelected,
                        onSelected: (_) => setModalState(() => selectedType = type),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Como você está se sentindo?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (noteController.text.trim().isEmpty) return;
                        setState(() {
                          _entries.insert(
                            0,
                            JournalEntry(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              date: DateTime.now(),
                              type: selectedType,
                              note: noteController.text.trim(),
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ({IconData icon, Color color, String label}) _typeConfig(JournalEntryType type) {
    switch (type) {
      case JournalEntryType.urge:
        return (icon: Icons.warning_amber_rounded, color: AppColors.crisisAction, label: 'Resisti a uma vontade');
      case JournalEntryType.relapse:
        return (icon: Icons.replay_rounded, color: AppColors.danger, label: 'Recaída');
      case JournalEntryType.reflection:
        return (icon: Icons.emoji_events_outlined, color: AppColors.success, label: 'Reflexão / vitória');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
