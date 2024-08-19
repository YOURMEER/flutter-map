import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermap/firebase_login/register_screen.dart';
import 'package:fluttermap/firebase_login/singup_screen.dart';
import 'package:fluttermap/home_screen.dart';
import 'package:fluttermap/main_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/firstadmin_screen.dart';

void main() {
  runApp(const StartUp());
}

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  bool _showLoginScreen = false;

  void _showLogin() {
    setState(() {
      _showLoginScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _showLoginScreen
          ? const LoginScreen()
          : StartupScreen(onStartPressed: _showLogin),
    );
  }
}

class StartupScreen extends StatelessWidget {
  final VoidCallback onStartPressed;

  const StartupScreen({super.key, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to CityMap",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Explore the city with our comprehensive map. Find landmarks, restaurants, and more with ease. Discover hidden gems and navigate your way through the city like a local.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Let's Start",
                    onPressed: onStartPressed,
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

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
      setState(() {});
    });
    _rippleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  void _onHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
      if (hovering) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              decoration: BoxDecoration(
                gradient: _isHovered
                    ? const LinearGradient(
                  colors: [Color(0xFF021D4E), Color(0xFF1FD7E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : const LinearGradient(
                  colors: [Color(0xFF0E0E1A), Color(0xFF0E0E1A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered ? const Color(0xFF1F4C65) : Colors.transparent,
                    blurRadius: 30.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Text(
                widget.text.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFEAEAEA),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_isHovered)
              CustomPaint(
                painter: RipplePainter(_rippleAnimation.value),
                size: const Size(150, 50),
              ),
          ],
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double radius;

  RipplePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3 * (1 - radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 + 4 * radius;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = sqrt(size.width * size.width + size.height * size.height);
    canvas.drawCircle(center, radius * maxRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isHidePassword = true;

  void userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text);
        SharedPreferences userlogged = await SharedPreferences.getInstance();
      userlogged.setString("_emailController",_emailController.text);


      // Role-based navigation
      if (_emailController.text == 'warda@gmail.com') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainNavbar()),
        );
      }




      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful")),
      );
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ex.message ?? "Login Failed")),
      );
    }
  }

  late AnimationController _animationController;
  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _signUpAnimation;
  late Animation<Offset> _forgotPasswordAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _colorTween = ColorTween(
      begin: Colors.blue,
      end: Colors.purple,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimationController.repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );

    _signUpAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.easeInOut),
      ),
    );

    _forgotPasswordAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_colorTween.value!, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
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
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: Offset.zero,
                    ).animate(_animationController),
                    child: ScaleTransition(
                      scale: _animation,
                      child: const Icon(
                        Icons.location_on,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _opacityAnimation.value,
                    duration: const Duration(milliseconds: 400),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isHidePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_isHidePassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidePassword = !_isHidePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              userLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _signUpAnimation,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        // Navigate to sign up
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _forgotPasswordAnimation,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                        // Navigate to forgot password
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
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

class FloatingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
