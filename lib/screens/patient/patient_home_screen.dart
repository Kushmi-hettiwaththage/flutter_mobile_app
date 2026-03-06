import 'package:flutter/material.dart';
import 'order_medicine_screen.dart';
import 'profile_screen.dart';
import 'track_delivery_screen.dart';
import '../../widgets/gradient_text.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _openDrawerScreen(Widget screen) {
    Navigator.pop(context);
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const GradientText(
          "Patient Dashboard",
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
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
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
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 46,
                      errorBuilder: (_, __, ___) => Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4EA1FF), Color(0xFF2F80ED)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.local_pharmacy_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    _DrawerItem(
                      icon: Icons.history_rounded,
                      title: "Prescription History",
                      onTap: () => _openDrawerScreen(const PrescriptionsScreen()),
                    ),
                    _DrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      onTap: () => _openDrawerScreen(const OrderMedicineScreen()),
                    ),
                    _DrawerItem(
                      icon: Icons.payment_rounded,
                      title: "Payment Method",
                      onTap: () => _openDrawerScreen(
                        const _FeaturePlaceholderScreen(
                          title: 'Payment Method',
                          subtitle: 'Manage your card and cash-on-delivery preferences.',
                          icon: Icons.payment_rounded,
                        ),
                      ),
                    ),
                    _DrawerItem(
                      icon: Icons.notifications_none_rounded,
                      title: "Notifications",
                      onTap: () => _openDrawerScreen(
                        const _FeaturePlaceholderScreen(
                          title: 'Notifications',
                          subtitle: 'All your pharmacy and order alerts will appear here.',
                          icon: Icons.notifications_active_outlined,
                        ),
                      ),
                    ),
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      title: "Settings",
                      onTap: () => _openDrawerScreen(
                        const _FeaturePlaceholderScreen(
                          title: 'Settings',
                          subtitle: 'Control app preferences and account options.',
                          icon: Icons.settings_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _openDrawerScreen(const PatientProfileScreen()),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Jane Alexa",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "View Profile",
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
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  const Text(
                    'Hello Jane,',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const GradientText(
                    'What do you need today?',
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
                  const SizedBox(height: 18),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.96,
                      children: [
                        _ActionCard(
                          title: "My Prescriptions",
                          subtitle: "Track active meds",
                          icon: Icons.description_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrescriptionsScreen(),
                              ),
                            );
                          },
                        ),
                        _ActionCard(
                          title: "Pharmacies",
                          subtitle: "Nearby options",
                          icon: Icons.local_pharmacy_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PharmaciesScreen(),
                              ),
                            );
                          },
                        ),
                        _ActionCard(
                          title: "Order Medicine",
                          subtitle: "Fast refill orders",
                          icon: Icons.shopping_cart_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OrderMedicineScreen(),
                              ),
                            );
                          },
                        ),
                        _ActionCard(
                          title: "Track Delivery",
                          subtitle: "Live status updates",
                          icon: Icons.local_shipping_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TrackDeliveryScreen(),
                              ),
                            );
                          },
                        ),
                        _ActionCard(
                          title: "Consultation",
                          subtitle: "Start video consult",
                          icon: Icons.video_call_outlined,
                          onTap: () {},
                        ),
                        _ActionCard(
                          title: "Reminders",
                          subtitle: "Never miss a dose",
                          icon: Icons.alarm_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Messages',
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(icon, color: const Color(0xFF2F80ED)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1F3A5A),
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

class _FeaturePlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _FeaturePlaceholderScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD7E5FF)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 42, color: const Color(0xFF2F80ED)),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF10243E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4A607E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFFFDFEFF), Color(0xFFF2F8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: const Color(0xFFD7E5FF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x171D5EBA),
                blurRadius: 22,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4EA1FF), Color(0xFF2F80ED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0E2B48),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF4A607E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            top: -100,
            right: -70,
            child: _Circle(size: 260, color: Color(0x3349A1FF)),
          ),
          Positioned(
            bottom: -90,
            left: -60,
            child: _Circle(size: 250, color: Color(0x2687D0FF)),
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

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const GradientText(
            "My Prescriptions",
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
          bottom: const TabBar(
            tabs: [
              Tab(text: "Ongoing"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OngoingPrescriptionsTab(),
            CompletedPrescriptionsTab(),
          ],
        ),
      ),
    );
  }
}

class OngoingPrescriptionsTab extends StatelessWidget {
  const OngoingPrescriptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _PrescriptionTile(
          title: "Prescription 1",
          subtitle: "Details about ongoing prescription 1",
        ),
        _PrescriptionTile(
          title: "Prescription 2",
          subtitle: "Details about ongoing prescription 2",
        ),
      ],
    );
  }
}

class CompletedPrescriptionsTab extends StatelessWidget {
  const CompletedPrescriptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _PrescriptionTile(
          title: "Prescription A",
          subtitle: "Details about completed prescription A",
        ),
        _PrescriptionTile(
          title: "Prescription B",
          subtitle: "Details about completed prescription B",
        ),
      ],
    );
  }
}

class _PrescriptionTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PrescriptionTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0EAFE)),
      ),
      child: ListTile(
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0x142F80ED),
          ),
          child: const Icon(Icons.description_outlined, color: Color(0xFF2F80ED)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GradientText(
          "Nearby Pharmacies",
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
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: const [
          PharmacyCard(
            name: "Pharmacy 1",
            address: "123 Main Street, San Francisco",
            distance: "0.5 miles",
          ),
          PharmacyCard(
            name: "Pharmacy 2",
            address: "456 Market Street, San Francisco",
            distance: "1.2 miles",
          ),
          PharmacyCard(
            name: "Pharmacy 3",
            address: "789 Mission Street, San Francisco",
            distance: "2.0 miles",
          ),
        ],
      ),
    );
  }
}

class PharmacyCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;

  const PharmacyCard({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFFDFEFF), Color(0xFFF2F8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD7E5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5B6E88),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                distance,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F80ED),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("View on Map"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
