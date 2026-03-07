import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import '../patient/patient_home_screen.dart';
import '../pharmacist/pharmacist_dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String role = "Patient";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  IconButton.filledTonal(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(height: 24),
                  const GradientText(
                    'Create account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFF17509C), Color(0xFF2F80ED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Set up your account and start tracking instantly.',
                    style: TextStyle(
                      color: Color(0xFF4A607E),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withValues(alpha: 0.9),
                      border: Border.all(color: const Color(0xFFD7E5FF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F1D5EBA),
                          blurRadius: 30,
                          offset: Offset(0, 14),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const _ModernInputField(
                          hintText: 'Full name',
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 14),
                        const _ModernInputField(
                          hintText: 'Email address',
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        const _ModernInputField(
                          hintText: 'Password',
                          icon: Icons.lock_outline_rounded,
                          obscureText: true,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          value: role,
                          style: const TextStyle(
                            color: Color(0xFF1B3553),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Select role',
                            hintStyle: const TextStyle(
                              color: Color(0xFF7A93B4),
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(9),
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFEFF6FF),
                              ),
                              child: const Icon(
                                Icons.badge_outlined,
                                color: Color(0xFF2F80ED),
                                size: 19,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(minWidth: 56),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Patient",
                              child: Text("Patient"),
                            ),
                            DropdownMenuItem(
                              value: "Pharmacist",
                              child: Text("Pharmacist"),
                            ),
                            DropdownMenuItem(
                              value: "Admin",
                              child: Text("Admin"),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              role = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Widget target = const PatientHomeScreen();
                              if (role == 'Pharmacist') {
                                target = const PharmacistDashboardScreen();
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => target),
                              );
                            },
                            child: const Text('Register'),
                          ),
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
    );
  }
}

class _ModernInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;

  const _ModernInputField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D103A73),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B3553),
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF7A93B4),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(9),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFEFF6FF),
            ),
            child: Icon(icon, color: const Color(0xFF2F80ED), size: 19),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 56),
        ),
      ),
    );
  }
}

class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF79C6FF), Color(0xFFEFF6FF), Color(0xFFFAFDFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: -60,
            right: -35,
            child: _Circle(size: 180, color: Color(0x3349A1FF)),
          ),
          Positioned(
            bottom: -80,
            left: -45,
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
