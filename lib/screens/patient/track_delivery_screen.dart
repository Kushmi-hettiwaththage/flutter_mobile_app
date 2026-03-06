import 'package:flutter/material.dart';

class DeliveryStep {
  final String title;
  final String subtitle;
  final String time;
  final bool completed;
  final bool current;

  const DeliveryStep({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.completed,
    required this.current,
  });
}

class TrackDeliveryScreen extends StatelessWidget {
  const TrackDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      DeliveryStep(
        title: 'Order Confirmed',
        subtitle: 'Your order has been received by the pharmacy.',
        time: '09:10 AM',
        completed: true,
        current: false,
      ),
      DeliveryStep(
        title: 'Packing Medicines',
        subtitle: 'Pharmacy is packing your medicines now.',
        time: '09:25 AM',
        completed: true,
        current: false,
      ),
      DeliveryStep(
        title: 'Out for Delivery',
        subtitle: 'Rider is on the way to your address.',
        time: '10:00 AM',
        completed: false,
        current: true,
      ),
      DeliveryStep(
        title: 'Delivered',
        subtitle: 'Your order will be marked complete once delivered.',
        time: 'Expected 10:30 AM',
        completed: false,
        current: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Track Delivery')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECF5FF), Color(0xFFF8FBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #ORD-438291',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Color(0xFF10243E),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Estimated Delivery: 10:30 AM',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Column(
                children: List.generate(
                  steps.length,
                  (index) => _DeliveryStepTile(
                    step: steps[index],
                    isLast: index == steps.length - 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryStepTile extends StatelessWidget {
  final DeliveryStep step;
  final bool isLast;

  const _DeliveryStepTile({
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = step.current
        ? const Color(0xFF2F80ED)
        : step.completed
            ? const Color(0xFF1E8E3E)
            : const Color(0xFF9FB2CC);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: step.current ? 18 : 14,
                  height: step.current ? 18 : 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent,
                    boxShadow: step.current
                        ? const [
                            BoxShadow(
                              color: Color(0x332F80ED),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: step.completed && !step.current
                      ? const Icon(Icons.check_rounded, size: 10, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD5E4FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8, bottom: 12, top: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: step.current ? const Color(0xFFEFF6FF) : const Color(0xFFF9FBFF),
                border: Border.all(
                  color: step.current ? const Color(0xFFB9D7FF) : const Color(0xFFE3EEFF),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF10243E),
                          ),
                        ),
                      ),
                      Text(
                        step.time,
                        style: const TextStyle(
                          color: Color(0xFF4A607E),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF4A607E),
                      fontSize: 13,
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
}
