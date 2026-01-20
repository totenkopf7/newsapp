import 'package:flutter/material.dart';
import 'home_page.dart';
import 'theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to home page after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/splash.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            // App name
            const Text(
              'AI News Assistant',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            // Tagline
            const Text(
              'Country • Language • Topic',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 40),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
              strokeWidth: 2,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // Developer credit
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.grey[50],
        child: const Center(
          child: Text(
            'Developed by Zinar Mizury',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
