import 'package:background_tracking_sample/sample_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Background Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleSplashScreen(title: 'Sample Background Tracking App'),
    );
  }
}
