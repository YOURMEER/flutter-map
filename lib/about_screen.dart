import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reswidth = MediaQuery.of(context).size.width;
    final resheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF171821), // Same background color as HomePage
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Background Gradient
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This Web',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome to our web platform! We are dedicated to providing the best city map services. Our platform offers detailed maps and various features to help you explore the city efficiently.',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our mission is to make city navigation easier for everyone. With real-time updates and user-friendly interfaces, we aim to enhance your city exploration experience.',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Explore the City Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: reswidth,
                    height: resheight * 0.4, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage('images/placeholder_map.png'), // Replace with your placeholder map image
                        fit: BoxFit.cover,
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
