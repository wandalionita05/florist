import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:florist/constants/appConstants.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/utils/helper.dart';
import 'package:florist/views/common_widgets/profileList.dart';
import 'package:lottie/lottie.dart';
import 'package:florist/views/welcome.dart';
import 'package:florist/domain/user_controller.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  static final Email email = Email(
    body: '',
    subject: 'subject',
    recipients: ['rami.omar.ayache@gmail.com'],
    isHTML: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// AVATAR
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      Assets.imagesUser,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// USER INFO (REAKTIF)
            Obx(() => Text(
                  userController.name.value.isEmpty
                      ? 'Guest'
                      : userController.name.value,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            Obx(() => Text(
                  userController.email.value.isEmpty
                      ? 'user app'
                      : userController.email.value,
                  style: Theme.of(context).textTheme.bodySmall,
                )),

            const SizedBox(height: 16),
            const Divider(thickness: 0.1),
            const SizedBox(height: 10),

            /// MENU
            ProfileMenuWidget(
              title: "Profile preferences",
              icon: Icons.account_circle,
              onPress: () => Get.toNamed('/profile-edit'),
            ),
            ProfileMenuWidget(
              title: "Delivery preferences",
              icon: Icons.delivery_dining,
              onPress: () => Get.toNamed('/delivery-preferences'),
            ),
            ProfileMenuWidget(
              title: "Change location",
              icon: Icons.settings,
              onPress: () => Get.toNamed('/change-location'),
            ),

            const Divider(thickness: 0.1),
            const SizedBox(height: 10),

            ProfileMenuWidget(
              title: "Terms & Conditions",
              icon: Icons.info,
              onPress: () => Get.toNamed('/terms-conditions'),
            ),

            ProfileMenuWidget(
              title: "About us",
              icon: Icons.developer_mode_rounded,
              endIcon: false,
              onPress: () {
                Get.dialog(
                  Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Made With ❤️ By #${AppConstants.projectOwnerName}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          Lottie.asset(
                            Assets.imagesCatThinking,
                            width: 300,
                            repeat: false,
                            decoder: customDecoder,
                          ),
                          const SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (_, __) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (_) {},
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () async {
                              await FlutterEmailSender.send(email);
                            },
                            child: const Text("Email us"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            ProfileMenuWidget(
              title: "Log Out",
              icon: Icons.logout,
              onPress: () {
                userController.clearUser();
                Get.offAll(() => WelcomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
