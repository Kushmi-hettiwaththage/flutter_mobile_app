import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pharmacy {
  final String name;
  final String address;
  final bool isOpen;
  final String distance;

  const Pharmacy({
    required this.name,
    required this.address,
    required this.isOpen,
    required this.distance,
  });
}

class OrderMedicineScreen extends StatefulWidget {
  const OrderMedicineScreen({super.key});

  @override
  State<OrderMedicineScreen> createState() => _OrderMedicineScreenState();
}

class _OrderMedicineScreenState extends State<OrderMedicineScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Pharmacy> _pharmacies = const [
    Pharmacy(
      name: 'City Care Pharmacy',
      address: '45 Main Street, Colombo',
      isOpen: true,
      distance: '0.6 km',
    ),
    Pharmacy(
      name: 'HealthHub Pharmacy',
      address: '22 Park Road, Colombo',
      isOpen: false,
      distance: '1.3 km',
    ),
    Pharmacy(
      name: 'MediQuick Pharmacy',
      address: '18 Galle Road, Colombo',
      isOpen: true,
      distance: '2.1 km',
    ),
  ];
  late List<Pharmacy> _filteredPharmacies;
  Pharmacy? _focusedPharmacy;

  @override
  void initState() {
    super.initState();
    _filteredPharmacies = _pharmacies;
    _focusedPharmacy = _pharmacies.first;
    _searchController.addListener(_filterPharmacies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPharmacies() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredPharmacies = _pharmacies
          .where(
            (pharmacy) =>
                pharmacy.name.toLowerCase().contains(query) ||
                pharmacy.address.toLowerCase().contains(query),
          )
          .toList();
      if (_filteredPharmacies.isNotEmpty &&
          !_filteredPharmacies.contains(_focusedPharmacy)) {
        _focusedPharmacy = _filteredPharmacies.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Medicine'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search pharmacies',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFD8E8FF), Color(0xFFF3F8FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: const [
                          Icon(Icons.map_rounded, color: Color(0xFF2F80ED)),
                          SizedBox(width: 8),
                          Text(
                            'Map Preview',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F3A5A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 38,
                            color: Color(0xFF2F80ED),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _focusedPharmacy?.name ?? 'No pharmacy selected',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF10243E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _focusedPharmacy?.address ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF4A607E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _filteredPharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = _filteredPharmacies[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD7E5FF)),
                  ),
                  child: ListTile(
                    onTap: () => setState(() => _focusedPharmacy = pharmacy),
                    contentPadding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                    title: Text(
                      pharmacy.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('${pharmacy.address}\n${pharmacy.distance} away'),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderMedicineDetailsScreen(pharmacy: pharmacy),
                          ),
                        );
                      },
                      child: const Text('Select'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum PaymentMethod { card, cod }

class OrderMedicineDetailsScreen extends StatefulWidget {
  final Pharmacy pharmacy;

  const OrderMedicineDetailsScreen({
    super.key,
    required this.pharmacy,
  });

  @override
  State<OrderMedicineDetailsScreen> createState() => _OrderMedicineDetailsScreenState();
}

class _OrderMedicineDetailsScreenState extends State<OrderMedicineDetailsScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _medicinesController =
      TextEditingController(text: 'Paracetamol 500mg, Vitamin C 1000mg');
  final TextEditingController _nameController =
      TextEditingController(text: 'Jane Alexa');
  final TextEditingController _contactController =
      TextEditingController(text: '+94 77 123 4567');
  final TextEditingController _addressController =
      TextEditingController(text: '12 Lake View Road, Colombo 05');
  File? _prescriptionImage;
  PaymentMethod _paymentMethod = PaymentMethod.card;

  @override
  void dispose() {
    _notesController.dispose();
    _medicinesController.dispose();
    _nameController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickPrescription() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile == null) return;
    setState(() {
      _prescriptionImage = File(pickedFile.path);
    });
  }

  void _proceedToPay() {
    final medicines = _medicinesController.text
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderCheckoutScreen(
          pharmacy: widget.pharmacy,
          paymentMethod: _paymentMethod,
          customerName: _nameController.text.trim(),
          contactNumber: _contactController.text.trim(),
          deliveryAddress: _addressController.text.trim(),
          notes: _notesController.text.trim(),
          hasPrescription: _prescriptionImage != null,
          orderId: orderId,
          medicines: medicines,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pharmacy = widget.pharmacy;
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Pharmacy',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pharmacy.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(pharmacy.address),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: pharmacy.isOpen
                          ? const Color(0x1428A745)
                          : const Color(0x14D9534F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      pharmacy.isOpen ? 'Open now' : 'Closed now',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: pharmacy.isOpen
                            ? const Color(0xFF1E8E3E)
                            : const Color(0xFFC53935),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prescription Upload',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_prescriptionImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _prescriptionImage!,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF4F8FF),
                        border: Border.all(color: const Color(0xFFDCE7F8)),
                      ),
                      alignment: Alignment.center,
                      child: const Text('No prescription selected'),
                    ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _pickPrescription,
                      icon: const Icon(Icons.upload_file_rounded),
                      label: Text(
                        _prescriptionImage == null
                            ? 'Upload Prescription Image'
                            : 'Change Prescription Image',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      hintText: 'Contact Number',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _addressController,
                    minLines: 2,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Delivery Address',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _medicinesController,
                    minLines: 2,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Medicine Names (comma separated)',
                      prefixIcon: Icon(Icons.medication_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Credit / Debit Card'),
                    value: _paymentMethod == PaymentMethod.card,
                    onChanged: (value) {
                      if (!value) return;
                      setState(() => _paymentMethod = PaymentMethod.card);
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Cash on Delivery'),
                    value: _paymentMethod == PaymentMethod.cod,
                    onChanged: (value) {
                      if (!value) return;
                      setState(() => _paymentMethod = PaymentMethod.cod);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _notesController,
                    minLines: 2,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Add notes for pharmacy (optional)',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _proceedToPay,
                child: const Text('Proceed to Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCheckoutScreen extends StatelessWidget {
  final Pharmacy pharmacy;
  final PaymentMethod paymentMethod;
  final String customerName;
  final String contactNumber;
  final String deliveryAddress;
  final String notes;
  final bool hasPrescription;
  final String orderId;
  final List<String> medicines;

  const OrderCheckoutScreen({
    super.key,
    required this.pharmacy,
    required this.paymentMethod,
    required this.customerName,
    required this.contactNumber,
    required this.deliveryAddress,
    required this.notes,
    required this.hasPrescription,
    required this.orderId,
    required this.medicines,
  });

  String get _paymentLabel =>
      paymentMethod == PaymentMethod.card ? 'Credit / Debit Card' : 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment & Order Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Payment Method',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _paymentLabel,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (paymentMethod == PaymentMethod.card) ...[
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Card Number',
                        prefixIcon: Icon(Icons.credit_card_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(hintText: 'MM/YY'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(hintText: 'CVV'),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F8FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDCE7F8)),
                      ),
                      child: const Text(
                        'Cash will be collected at delivery after order confirmation.',
                        style: TextStyle(color: Color(0xFF1F3A5A)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _detailRow('Pharmacy', pharmacy.name),
                  _detailRow('Order ID', orderId),
                  _detailRow('Name', customerName),
                  _detailRow('Contact', contactNumber),
                  _detailRow('Address', deliveryAddress),
                  _detailRow('Prescription', hasPrescription ? 'Uploaded' : 'Not Uploaded'),
                  _detailRow('Payment', _paymentLabel),
                  _detailRow(
                    'Medicines',
                    medicines.isEmpty ? 'N/A' : medicines.join(', '),
                  ),
                  if (notes.isNotEmpty) _detailRow('Notes', notes),
                  const Divider(height: 24),
                  _detailRow('Order Total', 'LKR 3,450.00'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showOrderOverlay(context),
                child: const Text('View Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF4A607E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'N/A' : value,
              style: const TextStyle(
                color: Color(0xFF10243E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderOverlay(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD7E5FF)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            _detailRow('Name', customerName),
            _detailRow('Order ID', orderId),
            _detailRow('Contact', contactNumber),
            _detailRow('Address', deliveryAddress),
            _detailRow('Pharmacy', pharmacy.name),
            _detailRow('Payment', _paymentLabel),
            _detailRow(
              'Medicines',
              medicines.isEmpty ? 'N/A' : medicines.join(', '),
            ),
            _detailRow('Order Total', 'LKR 3,450.00'),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFEFF6FF),
              ),
              child: const Text(
                'We will packing your medicine order soon!',
                style: TextStyle(
                  color: Color(0xFF1F3A5A),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
