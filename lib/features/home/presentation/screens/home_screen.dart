import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../apod/presentation/screens/apod_screen.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../neo/presentation/screens/neo_list_screen.dart';
import '../../../solar/presentation/screens/solar_screen.dart';

/*
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aestro Vista"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOut());
              // Navigate back to Login
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              "Welcome, Explorer!",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? "Ready to explore the universe?",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // 1. APOD Option
            _buildFeatureCard(
              context,
              title: "Picture of the Day",
              description: "Discover the cosmos, one photo at a time.",
              icon: Icons.camera_alt,
              color: Colors.deepPurpleAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ApodScreen()),
              ),
            ),

            const SizedBox(height: 16),

            // 2. NEO Option
            _buildFeatureCard(
              context,
              title: "Near Earth Objects",
              description: "Track asteroids passing close to Earth.",
              icon: Icons.public,
              // Or rocks/terrain icon
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NeoListScreen()),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Solar Weather Option
            _buildFeatureCard(
              context,
              title: "Space Weather",
              description: "Solar flares, storms, and CMEs.",
              icon: Icons.wb_sunny,
              color: Colors.orangeAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SolarScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
*/


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Define colors used in the design
  Color get bgDark => const Color(0xFF0B0F19);

  Color get cardBg => const Color(0xFF1A1F2E).withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      // Extend body behind app bar for transparent effect
      extendBodyBehindAppBar: true,
      // Set dark background color
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Astro Vista",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
            shadows: [
              // White/Blue glow effect for the title
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
              ),
              const BoxShadow(
                color: Colors.white,
                blurRadius: 5,
              ),
            ],
          ),
        ),
        actions: [
          // Keep logout as it is, just ensure icon is light
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white70),
            onPressed: () {
              // Assuming AuthBloc and LoginScreen exist as per your prompt
              // context.read<AuthBloc>().add(AuthSignOut());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
              print("Logout pressed - add your bloc/nav logic here");
            },
          ),
        ],
      ),
      // Using a Stack to add the faint background stars/glow if desired later
      body: Stack(
        children: [
          // Optional: Add a subtle top glow like the login screen if desired
          /*
         Positioned(
           top: -150, left: 0, right: 0,
           child: Center(
             child: Container(
               width: 300, height: 300,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 boxShadow: [BoxShadow(color: const Color(0xFF3D5AFE).withOpacity(0.2), blurRadius: 100, spreadRadius: 50)],
               ),
             ),
           ),
         ),
         */

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Welcome Section
                  Text(
                    "Welcome, Explorer!",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Light text
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? "Ready to explore the universe?",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: Colors.grey[400], // Subtler light text
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 1. APOD Option (Using Purple/Pink theme like screenshot card 1)
                  _buildNeonFeatureCard(
                    context,
                    title: "Picture of the Day",
                    description: "Discover the cosmos, one photo at a time.",
                    icon: Icons.camera_alt_outlined,
                    // Using outlined icons looks cleaner
                    primaryColor: const Color(0xFFBC4EFF),
                    // Purple Accent
                    secondaryColor: const Color(0xFF4E54FF),
                    // Blue/Purple shift
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const ApodScreen()));
                    },
                  ),

                  const SizedBox(height: 24),

                  // 2. NEO Option (Using Teal/Cyan theme like screenshot card 2)
                  _buildNeonFeatureCard(
                    context,
                    title: "Near Earth Objects",
                    description: "Track asteroids passing close to Earth.",
                    icon: Icons.public,
                    primaryColor: const Color(0xFF00E5FF),
                    // Cyan Accent
                    secondaryColor: const Color(0xFF00BFAE),
                    // Teal shift
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const NeoListScreen()));
                    },
                  ),

                  const SizedBox(height: 24),

                  // 3. Solar Weather Option (Using Deep Pink/Red theme similar to screenshot card 3)
                  _buildNeonFeatureCard(
                    context,
                    title: "Space Weather",
                    description: "Solar flares, storms, and CMEs.",
                    icon: Icons.wb_sunny_outlined,
                    primaryColor: const Color(0xFFFF4E9E),
                    // Pink/Magenta Accent
                    secondaryColor: const Color(0xFFFF8F4E),
                    // Orange shift
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const SolarScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Replaces the old _buildFeatureCard with the new neon design
  Widget _buildNeonFeatureCard(BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color primaryColor, // The main glow color
    required Color secondaryColor, // The gradient shift color
    required VoidCallback onTap,
  }) {
    // Using Container instead of Card for custom borders and shadows
    return Container(
      decoration: BoxDecoration(
        // Semi-transparent dark background fill
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
          // The "Neon" border effect defined by a gradient border and a shadow
          border: Border.all(
            color: primaryColor.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            // Subtle outer glow matching the primary color
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
          // Optional: Add a subtle gradient overlay to the card background itself
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cardBg,
                cardBg.withBlue(40),
                // slight shift closer to blue at bottom right
              ]
          )
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          splashColor: primaryColor.withOpacity(0.2),
          highlightColor: primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                // Icon Container
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    // Background is a semi-transparent mix of the two theme colors
                      color: Color.lerp(primaryColor, secondaryColor, 0.5)!
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: primaryColor.withOpacity(0.3), width: 1)
                  ),
                  // Icon is lighter, almost white, tinted slightly with primary color
                  child: Icon(
                      icon, color: Color.lerp(Colors.white, primaryColor, 0.2),
                      size: 28),
                ),
                const SizedBox(width: 20),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White title
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400], // Lighter grey description
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
