import 'package:flutter/material.dart';
import 'package:fluttermap/image_string.dart';
import 'package:fluttermap/text_strings.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';

// ProfileController class to manage text field states
class ProfileController extends GetxController {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void onClose() {
    fullname.dispose();
    email.dispose();
    phoneNo.dispose();
    password.dispose();
    super.onClose();
  }
}

class UpdateProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  UpdateProfileScreen({super.key});

  get tJoinedDate => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
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
                    bottom: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: tPrimaryColor,
                        child: const Icon(
                          LineAwesomeIcons.camera_solid,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.fullname,
                      decoration: const InputDecoration(
                        labelText: tFullName,
                        prefixIcon: Icon(Icons.person_outlined),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: controller.email,
                      decoration: const InputDecoration(
                        labelText: tEmail,
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: controller.phoneNo,
                      decoration: const InputDecoration(
                        labelText: tPhoneNo,
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: controller.password,
                      decoration: const InputDecoration(
                        labelText: tPassword,
                        prefixIcon: Icon(Icons.fingerprint),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle profile update logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: tJoined,
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: tJoined,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle profile delete logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                          ),
                          child: const Text(tDelete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
