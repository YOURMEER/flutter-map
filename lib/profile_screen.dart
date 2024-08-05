// profile_screen.dart

import 'package:flutter/material.dart';
import 'package:fluttermap/update_profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart'; // Assuming you are using GetX for navigation
import 'package:firebase_auth/firebase_auth.dart';
import 'text_strings.dart';
import 'package:fluttermap/image_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.moon),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text(
                      tProfileHeading,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      tProfileSubHeading,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const UpdateProfileScreen()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        tEditProfile,
                        style: TextStyle(color: tDarkColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              // Menu
              ProfileMenuWidget(
                title: "Setting",
                icon: LineAwesomeIcons.cog_solid,
                onPressed: () {},
              ),
              ProfileMenuWidget(
                title: "Billing Details",
                icon: LineAwesomeIcons.wallet_solid,
                onPressed: () {},
              ),
              ProfileMenuWidget(
                title: "User Management",
                icon: LineAwesomeIcons.user_check_solid,
                onPressed: () {},
              ),
              ProfileMenuWidget(
                title: "Information",
                icon: LineAwesomeIcons.info_solid,
                onPressed: () {},
              ),
              ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.arrow_alt_circle_right,
                textColor: Colors.red,
                endIcon: false,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateProfileScreen {
  const UpdateProfileScreen();
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return ListTile(
      leading: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(Icons.chevron_right, size: 18.0, color: Colors.grey),
      )
          : null,
      onTap: onPressed,
    );
  }
}
