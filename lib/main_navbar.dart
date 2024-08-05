import 'package:flutter/material.dart';
import 'package:fluttermap/home_screen.dart';
import 'package:fluttermap/profile_screen.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  _MainNavbarState createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List myScreens = [
    const HomePage(),
    const ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
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
      ),
    );
  }
}




