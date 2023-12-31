import 'dart:async';

import 'package:floyer/constants/app_constants.dart';
import 'package:floyer/helpers/distance_helper.dart';
import 'package:floyer/helpers/permission_helper.dart';
import 'package:floyer/pages/home/profiles_list.dart';
import 'package:floyer/pages/location_page.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:floyer/router.dart';
import 'package:floyer/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final hasPermission =
          await PermissionHelper().requestNotificationPermission();

      if (hasPermission) {
        NotificationService().setListeners();
      }

      if (await PermissionHelper().requestLocationPermission()) {
        if (await PermissionHelper().requestLocationService()) {
          Location.instance.onLocationChanged.listen((position) {
            final profiles = context.read<ProfileProvider>().profiles;
            if (profiles.isNotEmpty) {
              // Get the nearest profile and update the theme.
              final nearest = DistanceHelper.getNearestProfile(
                position.latitude!,
                position.longitude!,
                profiles,
              );
              if (nearest != null) {
                // Update the profile only if the nearest profile is different from
                context.read<ProfileProvider>().updateProfile(nearest);
              } else {
                context
                    .read<ProfileProvider>()
                    .updateProfile(AppConstants.fallbackProfile);
              }
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontSize:
                context.watch<ProfileProvider>().currentProfile.appBarTitleSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouter().push(const LocationPage()),
        child: const Icon(Icons.add_rounded),
      ),
      body: const ProfilesList(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
