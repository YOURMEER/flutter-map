import 'package:flutter/material.dart';
import 'package:fluttermap/admin/firstadmin_screen.dart'; // Adjust import based on your actual file structure



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: DrawerAdmin(),
      body: Center(child: Text("Welcome to the Home Screen")),
    );
  }
}

class DrawerAdmin extends StatefulWidget {
  const DrawerAdmin({super.key});

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  String selectedTile = '';

  @override
  Widget build(BuildContext context) {
    final reswidth = MediaQuery.of(context).size.width;
    final resheight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        color: Color(0xFF171821),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "rohan@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Drawer items
            buildListTile(
              resheight,
              'dashboard',
              Icons.dashboard,
              'Dashboard',
              context,
            ),
            buildListTile(
              resheight,
              'products',
              Icons.shopping_bag_outlined,
              'Products',
              context,
            ),
            buildListTile(
              resheight,
              'category',
              Icons.category_outlined,
              'Categories',
              context,
            ),
            buildListTile(
              resheight,
              'tracking',
              Icons.track_changes,
              'Tracking',
              context,
            ),
            buildListTile(
              resheight,
              'history',
              Icons.history,
              'History',
              context,
            ),
            buildListTile(
              resheight,
              'cart',
              Icons.card_travel_outlined,
              'Cart',
              context,
            ),
            SizedBox(height: resheight * 0.32),
            buildListTile(
              resheight,
              'settings',
              Icons.settings,
              'Settings',
              context,
            ),
            buildListTile(
              resheight,
              'logout',
              Icons.logout_outlined,
              'Logout',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      double resheight, String tileKey, IconData icon, String title, BuildContext context) {
    return Container(
      height: resheight * 0.045,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileKey == "logout"
            ? Colors.red
            : selectedTile == tileKey
            ? Colors.teal
            : Color(0xFF171821),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            setState(() {
              selectedTile = tileKey;
            });

            // Navigate based on the selected tile
            if (tileKey == 'dashboard') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admindashboard()),
              );
            } else if (tileKey == 'products') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductsScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'category') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'tracking') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackingScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'history') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'cart') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'settings') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()), // Replace with actual screen
              );
            } else if (tileKey == 'logout') {
              // Handle logout functionality
            }
          },
        ),
      ),
    );
  }
}

// Replace these with your actual screen widgets
class Admindashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: Center(child: Text("Welcome to the Admin Dashboard")),
    );
  }
}

// Add similar placeholder screens for ProductsScreen, CategoryScreen, TrackingScreen, HistoryScreen, CartScreen, and SettingsScreen
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Center(child: Text("Products Screen")),
    );
  }
}

// Add other screens similarly
class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Center(child: Text("Categories Screen")),
    );
  }
}

class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tracking")),
      body: Center(child: Text("Tracking Screen")),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Center(child: Text("History Screen")),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Center(child: Text("Cart Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Settings Screen")),
    );
  }
}
