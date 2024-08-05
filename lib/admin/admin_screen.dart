
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermap/admin/firstadmin_screen.dart';

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
            SizedBox(height: resheight * 0.1),
            buildListTile(
                resheight,
                'dashboard',
                Icons.dashboard,
                'Dashboard',
                context
            ),
            buildListTile(
                resheight,
                'products',
                Icons.shopping_bag_outlined,
                'Products',
                context
            ),buildListTile(
                resheight,
                'category',
                Icons.category_outlined,
                'Categories',
                context
            ),buildListTile(
                resheight,
                'tracking',
                Icons.track_changes,
                'Tracking',
                context
            ),buildListTile(
                resheight,
                'history',
                Icons.history,
                'History',
                context
            ),buildListTile(
                resheight,
                'cart',
                Icons.card_travel_outlined,
                'Cart',
                context
            ),

            SizedBox(height: resheight * 0.32,),

            buildListTile(
                resheight,
                'settings',
                Icons.settings,
                'Settings',
                context
            ),buildListTile(
                resheight,
                'logout',
                Icons.logout_outlined,
                'Logout',
                context
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      double resheight, String tileKey, IconData icon, String title,BuildContext context) {
    return Container(
      height: resheight * 0.045,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileKey == "logout" ? Colors.red : selectedTile == tileKey ? Colors.teal : Color(0xFF171821),
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
            tileKey == 'dashboard' ? Navigator.push(context, MaterialPageRoute(builder: (context) => Admindashboard())) : Text("data");
     //       tileKey == 'products' ? Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Data())) : Text("data");

            // Update the state of the app
            // ...
            // Then close the drawer
            // Navigator.pop(context);
          },
        ),
      ),
    );
  }
}


// DrawerHeader(
//
//   child: Column(
//     children: [
//       Text(
//         'Admin Panel',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24,
//         ),
//       ),
//       Text(
//         "rohan@gmail.com",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 18
//         ),
//
//       )
//     ],
//   ),
// ),