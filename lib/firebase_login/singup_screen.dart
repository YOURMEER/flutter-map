import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermap/home_screen.dart';
import 'package:fluttermap/main_navbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isHidePassword = true;
  bool _isHideConfirmPassword = true;

  late AnimationController _animationController;
  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _loginAnimation;
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

    _loginAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
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

  void userRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Successful"), backgroundColor: Colors.green),
        );
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ex.message ?? "Signup Failed"), backgroundColor: Colors.red),
        );
      }
    }
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
                      "Sign Up",
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
                            if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                              return "Please enter a valid email address";
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
                            if (value.trim().length < 6) {
                              return "Password must be at least 6 characters";
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
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _isHideConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().isEmpty) {
                              return "Please confirm your password";
                            } else if (value.trim() != _passwordController.text.trim()) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_isHideConfirmPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHideConfirmPassword = !_isHideConfirmPassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: userRegister,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            "Sign Up",
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
                    position: _loginAnimation,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to login
                      },
                      child: const Text(
                        "Already have an account? Log In",
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
