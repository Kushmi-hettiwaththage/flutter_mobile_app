import 'package:flutter/material.dart';
import '../../data/medication_reminder_repository.dart';
import '../../widgets/gradient_text.dart';

class PatientRemindersScreen extends StatelessWidget {
  final String patientName;

  const PatientRemindersScreen({
    super.key,
    this.patientName = 'Jane Alexa',
  });

  @override
  Widget build(BuildContext context) {
    final repo = MedicationReminderRepository.instance;
    return Scaffold(
      appBar: AppBar(
        title: const GradientText(
          'Medication Reminders',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
          gradient: LinearGradient(
            colors: [Color(0xFF17509C), Color(0xFF2F80ED)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFF6FF), Color(0xFFF9FCFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ValueListenableBuilder<List<MedicationReminder>>(
          valueListenable: repo.reminders,
          builder: (_, reminders, __) {
            final mine = reminders.where((r) => r.patientName == patientName).toList();
            if (mine.isEmpty) {
              return const Center(
                child: Text(
                  'No reminders yet.\nPharmacist-created schedules will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4A607E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: mine.length,
              itemBuilder: (_, index) {
                final reminder = mine[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD7E5FF)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              reminder.medicineName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Color(0xFF10243E),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: reminder.takenToday
                                  ? const Color(0x141E8E3E)
                                  : const Color(0x14D9534F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              reminder.takenToday ? 'Taken' : 'Pending',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: reminder.takenToday
                                    ? const Color(0xFF1E8E3E)
                                    : const Color(0xFFC53935),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${reminder.dosage} • ${reminder.frequency}\n${reminder.timeOfDay}',
                        style: const TextStyle(
                          color: Color(0xFF4A607E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Instructions: ${reminder.instructions}',
                        style: const TextStyle(color: Color(0xFF4A607E)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Set by: ${reminder.pharmacistName}',
                        style: const TextStyle(
                          color: Color(0xFF7A93B4),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Mark as taken today'),
                        value: reminder.takenToday,
                        onChanged: (value) {
                          repo.setTakenStatus(reminderId: reminder.id, taken: value);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
