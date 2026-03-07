import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../../data/medication_reminder_repository.dart';
import '../../widgets/gradient_text.dart';

class PharmacistPrescriptionQueueScreen extends StatelessWidget {
  const PharmacistPrescriptionQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('RX-2301', 'Jane Alexa', 'Paracetamol, Vitamin C', 'Urgent'),
      ('RX-2302', 'Nimal Perera', 'Amoxicillin, Cetirizine', 'Normal'),
      ('RX-2303', 'Kasuni Silva', 'Metformin 500mg', 'Normal'),
    ];
    return _FeatureScaffold(
      title: 'Prescription Queue',
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          return _FeatureCard(
            child: ListTile(
              title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${item.$2}\n${item.$3}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: item.$4 == 'Urgent' ? const Color(0x14D9534F) : const Color(0x14F0AD4E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.$4,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: item.$4 == 'Urgent' ? const Color(0xFFC53935) : const Color(0xFFAB7600),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PharmacistInventoryScreen extends StatelessWidget {
  const PharmacistInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meds = [
      ('Paracetamol 500mg', 'In Stock: 145', false),
      ('Amoxicillin 250mg', 'In Stock: 22', true),
      ('Metformin 500mg', 'In Stock: 80', false),
      ('Cetirizine 10mg', 'In Stock: 18', true),
    ];
    return _FeatureScaffold(
      title: 'Inventory',
      child: ListView(
        children: meds
            .map(
              (m) => _FeatureCard(
                child: ListTile(
                  leading: const Icon(Icons.medication_outlined, color: Color(0xFF2F80ED)),
                  title: Text(m.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(m.$2),
                  trailing: Text(
                    m.$3 ? 'Low' : 'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: m.$3 ? const Color(0xFFC53935) : const Color(0xFF1E8E3E),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PharmacistDispatchScreen extends StatelessWidget {
  const PharmacistDispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      ('ORD-438291', 'Ready for pickup', 'Nimal Perera'),
      ('ORD-438292', 'Packing', 'Kasuni Silva'),
      ('ORD-438293', 'Out for delivery', 'Ravin De Silva'),
    ];
    return _FeatureScaffold(
      title: 'Dispatch Orders',
      child: ListView(
        children: orders
            .map(
              (o) => _FeatureCard(
                child: ListTile(
                  title: Text(o.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text('${o.$3}\n${o.$2}'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Update'),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PharmacistPatientsScreen extends StatelessWidget {
  const PharmacistPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      ('Jane Alexa', '+94 77 123 4567'),
      ('Nimal Perera', '+94 71 887 0023'),
      ('Kasuni Silva', '+94 76 334 2211'),
    ];
    return _FeatureScaffold(
      title: 'Patients',
      child: ListView(
        children: patients
            .map(
              (p) => _FeatureCard(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEAF3FF),
                    child: Icon(Icons.person_rounded, color: Color(0xFF2F80ED)),
                  ),
                  title: Text(p.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(p.$2),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PharmacistReportsScreen extends StatelessWidget {
  const PharmacistReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Daily Reports',
      child: ListView(
        children: const [
          _FeatureCard(
            child: ListTile(
              title: Text('Orders Completed', style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: Text('36', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            ),
          ),
          _FeatureCard(
            child: ListTile(
              title: Text('Pending Prescriptions', style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: Text('18', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            ),
          ),
          _FeatureCard(
            child: ListTile(
              title: Text('Low Stock Items', style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: Text('6', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class PharmacistSettingsScreen extends StatelessWidget {
  const PharmacistSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Settings',
      child: ListView(
        children: const [
          _FeatureCard(child: ListTile(leading: Icon(Icons.notifications_none_rounded), title: Text('Notification Preferences'))),
          _FeatureCard(child: ListTile(leading: Icon(Icons.lock_outline_rounded), title: Text('Change Password'))),
          _FeatureCard(child: ListTile(leading: Icon(Icons.language_outlined), title: Text('Language'))),
          _FeatureCard(child: ListTile(leading: Icon(Icons.help_outline_rounded), title: Text('Help & Support'))),
        ],
      ),
    );
  }
}

class PharmacistProfileScreen extends StatelessWidget {
  const PharmacistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Pharmacist Profile',
      child: ListView(
        children: [
          const _FeatureCard(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFEAF3FF),
                child: Icon(Icons.person_rounded, color: Color(0xFF2F80ED)),
              ),
              title: Text('Dr. Senali Jayasinghe', style: TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Text('senali@pharmacy.com\n+94 77 900 1234'),
            ),
          ),
          const _FeatureCard(
            child: ListTile(
              leading: Icon(Icons.local_pharmacy_outlined),
              title: Text('Central Care Pharmacy'),
              subtitle: Text('No. 22 Park Road, Colombo'),
            ),
          ),
          const _FeatureCard(
            child: ListTile(
              leading: Icon(Icons.verified_outlined),
              title: Text('License Status'),
              trailing: Text('Verified', style: TextStyle(color: Color(0xFF1E8E3E), fontWeight: FontWeight.w700)),
            ),
          ),
          _FeatureCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PharmacistEditProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Profile'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PharmacistEditProfileScreen extends StatefulWidget {
  const PharmacistEditProfileScreen({super.key});

  @override
  State<PharmacistEditProfileScreen> createState() => _PharmacistEditProfileScreenState();
}

class _PharmacistEditProfileScreenState extends State<PharmacistEditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _profileBytes;
  final _nameController = TextEditingController(text: 'Dr. Senali Jayasinghe');
  final _emailController = TextEditingController(text: 'senali@pharmacy.com');
  final _phoneController = TextEditingController(text: '+94 77 900 1234');
  final _pharmacyController = TextEditingController(text: 'Central Care Pharmacy');
  final _addressController = TextEditingController(text: 'No. 22 Park Road, Colombo');
  final _licenseController = TextEditingController(text: 'PH-LIC-990012');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _pharmacyController.dispose();
    _addressController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 85);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    setState(() => _profileBytes = bytes);
  }

  void _choosePhoto() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pharmacist profile updated')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Edit Pharmacist Profile',
      child: ListView(
        children: [
          _FeatureCard(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: const Color(0xFFEAF3FF),
                        backgroundImage: _profileBytes != null ? MemoryImage(_profileBytes!) : null,
                        child: _profileBytes == null
                            ? const Icon(Icons.person_rounded, size: 44, color: Color(0xFF2F80ED))
                            : null,
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Material(
                          color: const Color(0xFF2F80ED),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _choosePhoto,
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _choosePhoto,
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Change Photo'),
                  ),
                ],
              ),
            ),
          ),
          _FeatureCard(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _input(_nameController, 'Full Name', Icons.person_outline_rounded),
                  const SizedBox(height: 8),
                  _input(_emailController, 'Email', Icons.mail_outline_rounded),
                  const SizedBox(height: 8),
                  _input(_phoneController, 'Phone', Icons.phone_outlined),
                  const SizedBox(height: 8),
                  _input(_pharmacyController, 'Pharmacy Name', Icons.local_pharmacy_outlined),
                  const SizedBox(height: 8),
                  _input(_addressController, 'Pharmacy Address', Icons.location_on_outlined, maxLines: 3),
                  const SizedBox(height: 8),
                  _input(_licenseController, 'License Number', Icons.verified_user_outlined),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String hint,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    );
  }
}

class PharmacistReminderManagementScreen extends StatefulWidget {
  const PharmacistReminderManagementScreen({super.key});

  @override
  State<PharmacistReminderManagementScreen> createState() =>
      _PharmacistReminderManagementScreenState();
}

class _PharmacistReminderManagementScreenState
    extends State<PharmacistReminderManagementScreen> {
  final _patientController = TextEditingController(text: 'Jane Alexa');
  final _medicineController = TextEditingController(text: 'Paracetamol 500mg');
  final _dosageController = TextEditingController(text: '1 tablet');
  final _frequencyController = TextEditingController(text: 'Twice a day');
  final _timeController = TextEditingController(text: '08:00 AM / 08:00 PM');
  final _instructionsController = TextEditingController(text: 'After meals');

  @override
  void dispose() {
    _patientController.dispose();
    _medicineController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    _timeController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _createReminder() {
    MedicationReminderRepository.instance.addReminder(
      patientName: _patientController.text.trim(),
      medicineName: _medicineController.text.trim(),
      dosage: _dosageController.text.trim(),
      frequency: _frequencyController.text.trim(),
      timeOfDay: _timeController.text.trim(),
      instructions: _instructionsController.text.trim(),
      pharmacistName: 'Dr. Senali Jayasinghe',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder created for patient')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = MedicationReminderRepository.instance;
    return _FeatureScaffold(
      title: 'Medication Reminders',
      child: ValueListenableBuilder<List<MedicationReminder>>(
        valueListenable: repo.reminders,
        builder: (_, reminders, __) {
          return ListView(
            children: [
              _FeatureCard(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _field(_patientController, 'Patient Name'),
                      const SizedBox(height: 8),
                      _field(_medicineController, 'Medicine'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _field(_dosageController, 'Dosage')),
                          const SizedBox(width: 8),
                          Expanded(child: _field(_frequencyController, 'Frequency')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _field(_timeController, 'Reminder Time'),
                      const SizedBox(height: 8),
                      _field(_instructionsController, 'Instructions'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createReminder,
                          child: const Text('Create Reminder'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ...reminders.map(
                (r) => _FeatureCard(
                  child: ListTile(
                    title: Text(
                      '${r.patientName} • ${r.medicineName}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${r.dosage}, ${r.frequency}\n${r.timeOfDay}\nTaken today: ${r.takenToday ? 'Yes' : 'No'}',
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: r.takenToday
                            ? const Color(0x141E8E3E)
                            : const Color(0x14D9534F),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        r.takenToday ? 'Taken' : 'Pending',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: r.takenToday
                              ? const Color(0xFF1E8E3E)
                              : const Color(0xFFC53935),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _field(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
    );
  }
}

class _FeatureScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const _FeatureScaffold({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          gradient: const LinearGradient(
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
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: child,
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final Widget child;

  const _FeatureCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7E5FF)),
      ),
      child: child,
    );
  }
}
