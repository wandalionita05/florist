import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/views/registration.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:florist/services/auth_service.dart';
import 'package:florist/domain/user_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi");
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await AuthService().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final UserController userController = Get.find<UserController>();
      userController.updateUser(
        name: result['user']['name'],
        email: result['user']['email'],
        phone: '-',
        address: '-',
      );

      Get.snackbar("Sukses", "Login berhasil");
      Get.offAllNamed('/dashboard');
    } catch (e) {
      Get.snackbar(
        "Login gagal",
        e.toString().replaceAll('Exception:', '').trim(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesWelcomeBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 44),
                  CircleAvatar(
                    backgroundColor: Get.theme.cardColor,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Assets.imagesAppIcon,
                        scale: 4.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Use your email and password to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const StadiumBorder(),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Get.to(() => const RegistrationScreen()),
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
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
