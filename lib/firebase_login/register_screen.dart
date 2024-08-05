import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _backToLoginAnimation;

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

    _colorTween = ColorTween(begin: Colors.blue[300], end: Colors.blue[900]).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimationController.repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
    ));

    _backToLoginAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
    ));

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
          AnimatedBuilder(
            animation: _colorAnimationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[300]!, _colorTween.value!],
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: Stack(
              children: [
                FloatingObject(
                  initialTop: 50,
                  initialLeft: 50,
                  size: 50,
                  duration: const Duration(seconds: 4),
                  child: Icon(Icons.airplanemode_active, color: Colors.white),
                ),
                FloatingObject(
                  initialTop: 200,
                  initialLeft: 100,
                  size: 40,
                  duration: const Duration(seconds: 5),
                  child: Icon(Icons.star, color: Colors.white),
                ),
                FloatingObject(
                  initialTop: 150,
                  initialLeft: 250,
                  size: 30,
                  duration: const Duration(seconds: 6),
                  child: Icon(Icons.circle, color: Colors.white),
                ),
                FloatingObject(
                  initialTop: 100,
                  initialLeft: 200,
                  size: 45,
                  duration: const Duration(seconds: 7),
                  child: Icon(Icons.star, color: Colors.white),
                ),
                FloatingObject(
                  initialTop: 250,
                  initialLeft: 50,
                  size: 55,
                  duration: const Duration(seconds: 8),
                  child: Icon(Icons.airplanemode_active, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green.withOpacity(0.7),
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
                        Icons.lock_open,
                        size: 120, // Increased size
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _opacityAnimation.value,
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 32, // Increased size
                        color: Colors.black,
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
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 30, // Increased size
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle password reset
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlideTransition(
                              position: _backToLoginAnimation,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  textStyle: const TextStyle(fontSize: 24),
                                ),
                                onPressed: () {
                                  // Navigate back to login
                                  Navigator.pop(context);
                                },
                                child: const Text("Back to Login"),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class FloatingObject extends StatefulWidget {
  final double initialTop;
  final double initialLeft;
  final double size;
  final Duration duration;
  final Widget child;

  const FloatingObject({
    required this.initialTop,
    required this.initialLeft,
    required this.size,
    required this.duration,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _FloatingObjectState createState() => _FloatingObjectState();
}

class _FloatingObjectState extends State<FloatingObject> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _topAnimation;
  late Animation<double> _leftAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _topAnimation = Tween<double>(begin: widget.initialTop, end: widget.initialTop - 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _leftAnimation = Tween<double>(begin: widget.initialLeft, end: widget.initialLeft + 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: _topAnimation.value,
          left: _leftAnimation.value,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: widget.child,
          ),
        );
      },
    );
  }
}
