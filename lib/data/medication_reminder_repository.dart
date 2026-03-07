import 'package:flutter/foundation.dart';

class MedicationReminder {
  final String id;
  final String patientName;
  final String medicineName;
  final String dosage;
  final String frequency;
  final String timeOfDay;
  final String instructions;
  final String pharmacistName;
  final bool takenToday;

  const MedicationReminder({
    required this.id,
    required this.patientName,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.timeOfDay,
    required this.instructions,
    required this.pharmacistName,
    required this.takenToday,
  });

  MedicationReminder copyWith({
    String? id,
    String? patientName,
    String? medicineName,
    String? dosage,
    String? frequency,
    String? timeOfDay,
    String? instructions,
    String? pharmacistName,
    bool? takenToday,
  }) {
    return MedicationReminder(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      instructions: instructions ?? this.instructions,
      pharmacistName: pharmacistName ?? this.pharmacistName,
      takenToday: takenToday ?? this.takenToday,
    );
  }
}

class MedicationReminderRepository {
  MedicationReminderRepository._();

  static final MedicationReminderRepository instance = MedicationReminderRepository._();

  final ValueNotifier<List<MedicationReminder>> reminders = ValueNotifier<List<MedicationReminder>>([
    const MedicationReminder(
      id: 'REM-1001',
      patientName: 'Jane Alexa',
      medicineName: 'Paracetamol 500mg',
      dosage: '1 tablet',
      frequency: 'Twice a day',
      timeOfDay: '08:00 AM / 08:00 PM',
      instructions: 'After meals',
      pharmacistName: 'Dr. Senali Jayasinghe',
      takenToday: false,
    ),
  ]);

  List<MedicationReminder> forPatient(String patientName) {
    return reminders.value.where((r) => r.patientName == patientName).toList();
  }

  void addReminder({
    required String patientName,
    required String medicineName,
    required String dosage,
    required String frequency,
    required String timeOfDay,
    required String instructions,
    required String pharmacistName,
  }) {
    final id = 'REM-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    reminders.value = [
      ...reminders.value,
      MedicationReminder(
        id: id,
        patientName: patientName,
        medicineName: medicineName,
        dosage: dosage,
        frequency: frequency,
        timeOfDay: timeOfDay,
        instructions: instructions,
        pharmacistName: pharmacistName,
        takenToday: false,
      ),
    ];
  }

  void setTakenStatus({
    required String reminderId,
    required bool taken,
  }) {
    reminders.value = reminders.value
        .map(
          (r) => r.id == reminderId ? r.copyWith(takenToday: taken) : r,
        )
        .toList();
  }
}
