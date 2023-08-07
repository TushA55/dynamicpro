import 'package:floyer/pages/device_profile_page.dart';
import 'package:floyer/router.dart';
import 'package:flutter/material.dart';

class CreateProfileDialog extends StatelessWidget {
  const CreateProfileDialog({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Device Profile"),
      content: const Text(
        "Create a new device profile which can be attached to this location.",
      ),
      actions: [
        TextButton(
          onPressed: AppRouter().pop,
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            AppRouter().pop();
            AppRouter().push(
              DeviceProfilePage(
                latitude: latitude,
                longitude: longitude,
              ),
            );
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}
