import 'package:aestro_vista/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';// Your Home Screen

/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSignUp = false; // Toggle between Login and Sign Up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          if (state is AuthAuthenticated) {
            // Navigate to Home on success
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSignUp ? "Create Account" : "Welcome Back",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isSignUp) {
                          context.read<AuthBloc>().add(AuthSignUp(
                            _emailController.text,
                            _passwordController.text,
                          ));
                        } else {
                          context.read<AuthBloc>().add(AuthSignIn(
                            _emailController.text,
                            _passwordController.text,
                          ));
                        }
                      },
                      child: Text(isSignUp ? "Sign Up" : "Log In"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Text(isSignUp
                        ? "Already have an account? Log In"
                        : "Don't have an account? Sign Up"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSignUp = false; // Toggle between Login and Sign Up
  bool isPasswordVisible = false; // Toggle for password eye icon

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the color palette based on the image
    final Color bgDark = const Color(0xFF0B0F19); // Deep dark background
    final Color primaryPurple = const Color(0xFF9D00FF);
    final Color primaryBlue = const Color(0xFF3D5AFE);
    final Color glowColor = const Color(0xFF5E60CE).withOpacity(0.5);

    return Scaffold(
      backgroundColor: bgDark,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryPurple,
              ),
            );
          }

          return Stack(
            children: [
              // 1. Background Elements (The top glow)
              Positioned(
                top: -100,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primaryBlue.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 2. Main Content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // --- Logo Section ---
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purpleAccent.shade100,
                              primaryBlue,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withOpacity(0.6),
                              blurRadius: 40,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // --- Title ---
                      Text(
                        "Astro Vista",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Explore the universe",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple.shade200,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 50),

                      // --- Email Input ---
                      _buildNeonTextField(
                        controller: _emailController,
                        hintText: "Email",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),

                      // --- Password Input ---
                      _buildNeonTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        isPasswordVisible: isPasswordVisible,
                        onVisibilityToggle: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),

                      const SizedBox(height: 40),

                      // --- Action Button (Gradient) ---
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [primaryPurple, primaryBlue],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryPurple.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isSignUp) {
                              context.read<AuthBloc>().add(AuthSignUp(
                                _emailController.text,
                                _passwordController.text,
                              ));
                            } else {
                              context.read<AuthBloc>().add(AuthSignIn(
                                _emailController.text,
                                _passwordController.text,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            isSignUp ? "Sign Up" : "Sign In",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // --- Footer Text ---
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSignUp = !isSignUp;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            children: [
                              TextSpan(
                                text: isSignUp
                                    ? "Already have an account? "
                                    : "Don't have an account? ",
                              ),
                              TextSpan(
                                text: isSignUp ? "Sign In" : "Sign Up",
                                style: TextStyle(
                                  color: Colors.purple.shade200,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- Helper Widget for the Neon Input Fields ---
  Widget _buildNeonTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool? isPasswordVisible,
    VoidCallback? onVisibilityToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141724), // Slightly lighter than bg
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF9D00FF).withOpacity(0.5), // Purple border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D00FF).withOpacity(0.2), // Neon glow
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !(isPasswordVisible ?? false),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(icon, color: Colors.purple.shade200),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible!
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.purple.shade200,
            ),
            onPressed: onVisibilityToggle,
          )
              : null,
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

