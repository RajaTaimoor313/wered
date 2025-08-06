import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';
import 'theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Initialize fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start fade animation
    _fadeController.forward();

    // Navigate to signup screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignupScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: themeProvider.gradientColors,
              ),
            ),
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    'assets/background_elements/3_background.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Top left decorative elements (lanterns)
                Positioned(
                  top: 0,
                  left: 20,
                  child: Image.asset(
                    isDarkMode
                        ? 'assets/background_elements/1.png'
                        : 'assets/background_elements/1_LE.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),

                // Center Arabic text (Bismillah) with fade-in animation
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 24,
                  right: 24,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Image.asset(
                            'assets/splash/﷽.png',
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Bottom mosque silhouette
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    isDarkMode
                        ? 'assets/background_elements/2.png'
                        : 'assets/background_elements/2_LE.png',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
