import 'package:background_tracking_sample/live_tracking_helper.dart';
import 'package:background_tracking_sample/location_service.dart';
import 'package:background_tracking_sample/sample_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SampleSplashScreen extends StatefulWidget {
  const SampleSplashScreen({super.key, required this.title});
  final String title;

  @override
  State<SampleSplashScreen> createState() => _SampleSplashScreenState();
}

class _SampleSplashScreenState extends State<SampleSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: checkLocationPermission,
              child: const Text(
                'Request Location Permission And Start The Plugin',
              ),
            ),
            ElevatedButton(
              onPressed: navigateToSampleLoginScreen,
              child: const Text(
                'Navigate To Next Page',
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> checkLocationPermission() async {
    final hasPermission = await Permission.location.isGranted;
    var isLocationServiceEnabled = await LocationService().location.serviceEnabled();
    if (!hasPermission) {
      await Permission.location.request();
    }
    if (!isLocationServiceEnabled) {
      isLocationServiceEnabled = await LocationService().location.requestService();
    }
    if (hasPermission && isLocationServiceEnabled) {
      LiveTrackingHelper().setLocationConfig();
    }
  }

  void navigateToSampleLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SampleLoginScreen(title: 'Sample Background Tracking App')),
    );
  }
}
