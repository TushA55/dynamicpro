import 'dart:async';

import 'package:floyer/constants/app_constants.dart';
import 'package:floyer/helpers/distance_helper.dart';
import 'package:floyer/helpers/location_helper.dart';
import 'package:floyer/helpers/permission_helper.dart';
import 'package:floyer/pages/home/profiles_list.dart';
import 'package:floyer/pages/location_page.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:floyer/router.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<Position>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PermissionHelper().requestNotificationPermission();

      final locationStream = await LocationHelper().locationStream();
      _locationSubscription = locationStream?.listen((position) {
        final profiles = context.read<ProfileProvider>().profiles;
        if (profiles.isNotEmpty) {
          // Get the nearest profile and update the theme.
          final nearest = DistanceHelper.getNearestProfile(
            position.latitude,
            position.longitude,
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
    _locationSubscription?.cancel();
    super.dispose();
  }
}
