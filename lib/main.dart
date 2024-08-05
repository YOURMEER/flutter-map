import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttermap/admin/firstadmin_screen.dart';
import 'package:fluttermap/home_screen.dart';
import 'package:fluttermap/main_navbar.dart';
import 'package:fluttermap/firebase_login/register_screen.dart';
import 'package:fluttermap/firebase_login/singup_screen.dart';
import 'package:fluttermap/firebase_login/startup_screen.dart';
import 'package:fluttermap/firebase_options.dart';
import 'package:fluttermap/profile_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Admindashboard() ,
    );
  }
}
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("HELLO BROTHER"),
      ),
    );
  }
}
