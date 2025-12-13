import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/views/common_widgets/appBar.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
        leading: InkResponse(onTap: () => Get.back(), child: BackButtonIcon()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TOP
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Get.theme.cardColor,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Assets.imagesAppIcon,
                        scale: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Create your account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Register to start using the app",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // FORM
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _inputField(
                      label: "Full Name",
                      hint: "Wanda",
                      controller: nameController,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _inputField(
                      label: "Email",
                      hint: "example@gmail.com",
                      controller: emailController,
                      icon: Icons.email,
                      keyboard: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _passwordField(),
                  ],
                ),
              ),
            ),

            // BUTTON
            Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO (register): Hubungkan ke API register
                      Get.offAllNamed('/dashboard');
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const StadiumBorder(),
                      backgroundColor: Get.theme.primaryColor,
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Get.toNamed('/login'),
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // CUSTOM TEXT FIELD
  Widget _inputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Get.theme.primaryColor),
            filled: true,
            fillColor: Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // PASSWORD FIELD
  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: "••••••••",
            prefixIcon: Icon(Icons.lock, color: Get.theme.primaryColor),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
            filled: true,
            fillColor: Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
