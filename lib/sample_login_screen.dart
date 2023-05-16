import 'package:background_tracking_sample/live_tracking_helper.dart';
import 'package:flutter/material.dart';

class SampleLoginScreen extends StatefulWidget {
  const SampleLoginScreen({super.key, required this.title});
  final String title;

  @override
  State<SampleLoginScreen> createState() => _SampleLoginScreenState();
}

class _SampleLoginScreenState extends State<SampleLoginScreen> {

  @override
  void initState() {
    super.initState();
    LiveTrackingHelper().configureLiveTracking();
  }

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
          children: const <Widget>[
            Text(
              'Sample Login Screen',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
