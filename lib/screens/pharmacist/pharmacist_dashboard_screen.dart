import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import 'pharmacist_feature_screens.dart';

class PharmacistDashboardScreen extends StatefulWidget {
  const PharmacistDashboardScreen({super.key});

  @override
  State<PharmacistDashboardScreen> createState() => _PharmacistDashboardScreenState();
}

class _PharmacistDashboardScreenState extends State<PharmacistDashboardScreen> {
  int _selectedIndex = 0;

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const GradientText(
          'Pharmacist Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
          gradient: LinearGradient(
            colors: [Color(0xFF17509C), Color(0xFF2F80ED)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF79C6FF), Color(0xFFEFF6FF), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 52, 12, 12),
                  children: [
                    _DrawerTile(
                      icon: Icons.dashboard_outlined,
                      title: 'Dashboard',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerTile(
                      icon: Icons.receipt_long_outlined,
                      title: 'Prescription Queue',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistPrescriptionQueueScreen());
                      },
                    ),
                    _DrawerTile(
                      icon: Icons.inventory_2_outlined,
                      title: 'Inventory',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistInventoryScreen());
                      },
                    ),
                    _DrawerTile(
                      icon: Icons.local_shipping_outlined,
                      title: 'Dispatch Orders',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistDispatchScreen());
                      },
                    ),
                    _DrawerTile(
                      icon: Icons.people_outline_rounded,
                      title: 'Patients',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistPatientsScreen());
                      },
                    ),
                    _DrawerTile(
                      icon: Icons.alarm_rounded,
                      title: 'Medication Reminders',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistReminderManagementScreen());
                      },
                    ),
                    _DrawerTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        _openScreen(const PharmacistSettingsScreen());
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.pop(context);
                  _openScreen(const PharmacistProfileScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(14),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withValues(alpha: 0.9),
                    border: Border.all(color: const Color(0xFFD7E5FF)),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/user_profile.jpg',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 48,
                            height: 48,
                            color: const Color(0xFFE7F1FF),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Color(0xFF2F80ED),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Senali Jayasinghe',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              color: Color(0xFF2F80ED),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const _DashboardBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: ListView(
                children: [
                  SizedBox(height: 36),
                  Text(
                    'Welcome back, Pharmacist',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  GradientText(
                    'Manage pharmacy operations',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFF17509C), Color(0xFF2F80ED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  SizedBox(height: 16),
                  _SummaryRow(onTap: _openScreen),
                  SizedBox(height: 12),
                  _ActionGrid(onTap: _openScreen),
                  SizedBox(height: 12),
                  _RecentOrdersCard(onTap: _openScreen),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            _openScreen(const PharmacistPrescriptionQueueScreen());
          }
          if (index == 2) {
            _openScreen(const PharmacistProfileScreen());
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Queue',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2F80ED)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1F3A5A),
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}

class _DashboardBackground extends StatelessWidget {
  const _DashboardBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF79C6FF), Color(0xFFEFF6FF), Color(0xFFF9FCFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: -90,
            right: -70,
            child: _Circle(size: 250, color: Color(0x3349A1FF)),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: _Circle(size: 230, color: Color(0x2687D0FF)),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;

  const _Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final void Function(Widget screen) onTap;

  const _SummaryRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Pending',
            value: '18',
            icon: Icons.pending_actions_outlined,
            onTap: () => onTap(const PharmacistPrescriptionQueueScreen()),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Ready',
            value: '12',
            icon: Icons.check_circle_outline_rounded,
            onTap: () => onTap(const PharmacistDispatchScreen()),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Low Stock',
            value: '6',
            icon: Icons.warning_amber_rounded,
            onTap: () => onTap(const PharmacistInventoryScreen()),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD7E5FF)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF2F80ED)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: Color(0xFF10243E),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4A607E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String title;
  final Widget screen;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}

class _ActionGrid extends StatelessWidget {
  final void Function(Widget screen) onTap;

  const _ActionGrid({required this.onTap});

  @override
  Widget build(BuildContext context) {
    const items = [
      _ActionItem(
        icon: Icons.receipt_long_outlined,
        title: 'Review Prescriptions',
        screen: PharmacistPrescriptionQueueScreen(),
      ),
      _ActionItem(
        icon: Icons.inventory_2_outlined,
        title: 'Update Inventory',
        screen: PharmacistInventoryScreen(),
      ),
      _ActionItem(
        icon: Icons.local_shipping_outlined,
        title: 'Dispatch Orders',
        screen: PharmacistDispatchScreen(),
      ),
      _ActionItem(
        icon: Icons.bar_chart_outlined,
        title: 'Daily Reports',
        screen: PharmacistReportsScreen(),
      ),
      _ActionItem(
        icon: Icons.alarm_rounded,
        title: 'Manage Reminders',
        screen: PharmacistReminderManagementScreen(),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => onTap(item.screen),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFDFEFF), Color(0xFFF2F8FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: const Color(0xFFD7E5FF)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4EA1FF), Color(0xFF2F80ED)],
                        ),
                      ),
                      child: Icon(item.icon, color: Colors.white, size: 20),
                    ),
                    const Spacer(),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF10243E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RecentOrdersCard extends StatelessWidget {
  final void Function(Widget screen) onTap;

  const _RecentOrdersCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD7E5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientText(
            'Recent Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF17509C), Color(0xFF2F80ED)],
            ),
          ),
          const SizedBox(height: 10),
          _OrderRow(
            orderId: 'ORD-438291',
            patient: 'Nimal Perera',
            status: 'Ready',
            onTap: () => onTap(const PharmacistDispatchScreen()),
          ),
          _OrderRow(
            orderId: 'ORD-438292',
            patient: 'Kasuni Silva',
            status: 'Pending',
            onTap: () => onTap(const PharmacistPrescriptionQueueScreen()),
          ),
          _OrderRow(
            orderId: 'ORD-438293',
            patient: 'Ravin De Silva',
            status: 'Dispatch',
            onTap: () => onTap(const PharmacistDispatchScreen()),
          ),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String orderId;
  final String patient;
  final String status;
  final VoidCallback onTap;

  const _OrderRow({
    required this.orderId,
    required this.patient,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: const TextStyle(
                      color: Color(0xFF10243E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    patient,
                    style: const TextStyle(
                      color: Color(0xFF4A607E),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Color(0xFF2F80ED),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
