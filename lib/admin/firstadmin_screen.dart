import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttermap/firebase_login/startup_screen.dart';
import 'package:fluttermap/main_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); // Adjust to use MyApp instead of RoleBasedScreen directly
}


// Main Application
class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return RoleBasedScreen(userId: "sampleUserId"); // Replace with the actual user ID
  }
}

// Role-based screen handling
class RoleBasedScreen extends StatelessWidget {

  final String userId;

  RoleBasedScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User not found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final userRole = userData['role'];
          final userEmail = userData['Email'];

          if (userRole == 'admin' && userEmail == 'warda@gmail.com') {
            return AdminDashboard();
          } else {
            return MainNavbar();
          }
        },
      ),
    );
  }
}

// Admin Dashboard Screen
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();

}


class _AdminDashboardState extends State<AdminDashboard> with TickerProviderStateMixin {
  List<String> vectorImages = ["images/fire.png", "images/soles.png", "images/distance.png", "images/night.png"];
  List<String> vectorText = ["305", "10,939", "7km", "7h48m"];
  List<String> vectorSubText = ["305", "10,939", "7km", "7h48m"];

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;

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
    final reswidth = MediaQuery.of(context).size.width;
    final resheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF171821),
      drawer: DrawerAdmin(),
      body: Stack(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: Icon(Icons.view_headline_outlined, color: Colors.grey[600], size: 30),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS-bz3w3YbiCPW23zQNWR0sjH7WNZFmCV_6Q&s'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resheight * 0.02),
                  Container(
                    width: reswidth * 0.9,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        filled: true,
                        fillColor: Color(0xFF21222D),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: resheight * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: reswidth * 0.35,
                          height: resheight * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF21222D),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: reswidth * 0.1,
                                height: resheight * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF21222D),
                                  image: DecorationImage(
                                    image: AssetImage(vectorImages[index]),
                                  ),
                                ),
                              ),
                              Text(vectorText[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                              Text(vectorSubText[index], style: TextStyle(color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: resheight * 0.05),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'Half yearly sales analysis'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SfSparkLineChart.custom(
                      trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
                      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
                      labelDisplayMode: SparkChartLabelDisplayMode.all,
                      xValueMapper: (int index) => data[index].year,
                      yValueMapper: (int index) => data[index].sales,
                      dataCount: 5,
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

// User Dashboard Screen
class UserDashboard extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Dashboard")),
      body: Center(child: Text("Welcome, User!")),
    );
  }
}

// Floating Element Widget
class FloatingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}

class DrawerAdmin extends StatefulWidget {
  const DrawerAdmin({super.key});

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

void userlogout(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  SharedPreferences userlogged = await SharedPreferences.getInstance();
  userlogged.clear();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}






class _DrawerAdminState extends State<DrawerAdmin> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Add navigation logic here if needed
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Add navigation logic here if needed
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              userlogout(context);
             
            },
          ),
        ],
      ),
    );;
  }
}


// Sales Data Class
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
