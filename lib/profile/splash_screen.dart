import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttermap/firebase_login/startup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_navbar.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void screenshifter()async{
    SharedPreferences userlogged = await SharedPreferences.getInstance();
    var userSession = userlogged.getString("_emailControll");
    if(userSession != null){
      Timer(Duration(milliseconds: 100),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>MainNavbar() )),);
    }else{
      Timer(Duration(milliseconds: 100),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>StartUp() )),);
    }


  }
  @override

  void initState() {
    // TODO: implement initState
    screenshifter();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTujXejzRuNXDxdi55A4-TKPdeuYtXB-zV-CQ&s'))
          ),
        ),
      ),
    );
  }
}
