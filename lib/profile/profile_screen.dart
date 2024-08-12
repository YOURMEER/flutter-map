import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermap/firebase_login/startup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
void userlogout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  SharedPreferences userlogged = await SharedPreferences.getInstance();
  userlogged.clear();

  // After logging out, navigate to the login page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login page widget
  );
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {



  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;
  int _selectedIndex = 1; // Default to Profile page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here if needed
    });
  }

  @override
  void initState() {
    super.initState();
    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.blueAccent,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("userData").snapshots(),
          builder:( context,snapshort){
            if(snapshort.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
              if(snapshort.hasData){
              return ListView.builder(itemBuilder: (context, index) {
                String userName = snapshort.data!.docs[index]["name"];


                Stack(
                  children: [
                    // Animated gradient background
                    AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_colorTween.value!, Colors.black],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    // Floating elements
                    Positioned(
                      top: 50,
                      left: 30,
                      child: FloatingElement(),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: FloatingElement(),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 80,
                      child: FloatingElement(),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 100,
                      child: FloatingElement(),
                    ),
                    // Foreground content
                    SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          // Profile image
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/7d2a57d4-23ee-4ccf-b34c-bd6ddbb1f4a8/width=450/00000-3694828998-A%20professional%20profile%20photo%20for%20linkedin%20of%20%20man,%20%20business%20clothing,%20at%20office,%20bokeh%20background,%20deep%20of%20field,%20kkw-ph1%20_lora.jpeg'), // Replace with actual profile image URL
                          ),
                          const SizedBox(height: 16),
                          // Profile name
                          Text(
                            userName, // Replace with actual name
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Profile email
                          Text(
                            '${FirebaseAuth.instance.currentUser!.email}', // Replace with actual email
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Other fields
                          ProfileField(
                            icon: Icons.phone,
                            label: 'Phone Number',
                            value: '+123456789', // Replace with actual phone number
                          ),
                          ProfileField(
                            icon: Icons.location_on,
                            label: 'Address',
                            value: '123 Main St, City, Country', // Replace with actual address
                          ),
                          ProfileField(
                            icon: Icons.calendar_today,
                            label: 'Date of Birth',
                            value: '27 Oct 2024', // Replace with actual DOB
                          ),
                          ProfileField(
                            icon: Icons.work,
                            label: 'Occupation',
                            value: 'Software Developer', // Replace with actual occupation
                          ),
                          const Spacer(),
                          // Logout button styled as a profile field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                userlogout(context);
                                // Handle logout logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Colors.redAccent,
                              ),
                              icon: const Icon(Icons.logout, color: Colors.white),
                              label: const Text('Logout', style: TextStyle(fontSize: 18, fontFamily: 'Montserrat')),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                );
              },);
              }

              if(snapshort.hasError){
                return  Center(child: Icon(Icons.error,color: Colors.red,),);
              }

            return Container();
          },),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.green), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.green), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class ProfileField extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.white),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 6,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}