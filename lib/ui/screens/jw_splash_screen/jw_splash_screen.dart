import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/just_weather.dart';
import 'package:just_weather_app/ui/states/jw_location_state.dart';

class JwSplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/jw_splash_screen';
  const JwSplashScreen({super.key});

  @override
  ConsumerState<JwSplashScreen> createState() => _JwSplashScreenState();
}

class _JwSplashScreenState extends ConsumerState<JwSplashScreen> {
  @override
  void initState() {
    super.initState();
    _initFlow();
  }

  Future<void> _initFlow() async {
    await Future.delayed(const Duration(milliseconds: 800));

    await ref.read(jwLocationControllerProvider.future);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => JwHomeScreen()),
      ModalRoute.withName(JwHomeScreen.roteName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 200),
            const SizedBox(height: 20),
            const Text(
              "Just Weather",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Obteniendo tu ubicación...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
