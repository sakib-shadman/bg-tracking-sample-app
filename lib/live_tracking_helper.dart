import 'dart:async';
import 'package:background_tracking_sample/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';

class LiveTrackingHelper {
  final String permissionExplanationMessage =
      '''Your location data will be used to track your live movement even when you are not using app. By accepting terms and conditions and location permission you are giving full consent to Background Location Tracking.''';

  Future<void> configureLiveTracking() async {
    try {
      await BackgroundGeolocation.setConfig(
        Config(
          enableHeadless: true,
          desiredAccuracy: Config.DESIRED_ACCURACY_HIGH,
          distanceFilter: 100,
          disableElasticity: true,
          stopOnTerminate: false,
          startOnBoot: true,
          isMoving: true,
          heartbeatInterval: 60,
          schedule: Constants.trackingSchedule,
          scheduleUseAlarmManager: true,
          backgroundPermissionRationale: PermissionRationale(
            message: permissionExplanationMessage,
          ),
          logLevel: Config.LOG_LEVEL_VERBOSE,
          maxDaysToPersist: Constants.maxDaysToPersist,
        ),
      );
      unawaited(BackgroundGeolocation.startSchedule());
    } catch (exception) {
      debugPrint(
        'EXCEPTION AT SET CONFIG AFTER LOGIN '
        'FOR BACKGROUND TRACKING: ${exception.toString()}',
      );
    }
  }

  Future<void> setLocationConfig() async {
    try {
      await BackgroundGeolocation.stop();
      await BackgroundGeolocation.stopSchedule();

      final status = await BackgroundGeolocation.ready(
        Config(
          reset: false,
          schedule: Constants.trackingSchedule,
          scheduleUseAlarmManager: true,
          distanceFilter: Constants.locationDistanceFilter,
          isMoving: true,
          maxDaysToPersist: Constants.maxDaysToPersist,
        ),
      );
      BackgroundGeolocation.onLocation(locationUpdateCallBack);

      if (!status.enabled) {
        await BackgroundGeolocation.start();
        await BackgroundGeolocation.startSchedule();
      }
    } catch (exception) {
      debugPrint(
        'EXCEPTION AT READY AT SPLASH '
        'FOR BACKGROUND TRACKING: ${exception.toString()}',
      );
    }
  }

  void locationUpdateCallBack(Location location) {
    debugPrint('Current location: $location');
  }
}
