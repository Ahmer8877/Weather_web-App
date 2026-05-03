import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //init state
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        context.pushReplacement('/main');
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    //main root of screen
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Upper Text
            const Text(
              "Welcome To",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            //  Animated Icon
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.newspaper_rounded,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // App Name
            const Text(
              "Daily Weather Info",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 8),

            //  Tagline
            const Text(
              "Stay Informed, Stay Ahead",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 50),

            //  Loading Indicator(lottie)
            SizedBox(
              width: 300,
              height: 30,
              child: Lottie.asset('assets/loadings/dots.json',fit: BoxFit.fitWidth)
            ),
          ],
        ),
      ),
    );
  }
}
