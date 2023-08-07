import 'package:floyer/router.dart';
import 'package:flutter/material.dart';

class LocationExistDialog extends StatelessWidget {
  const LocationExistDialog({super.key, required this.nearest});

  final String nearest;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Location already exists"),
      content: Text(
        "A location with the name '$nearest' already exists at this location. Try creating another location.",
      ),
      actions: [
        TextButton(
          onPressed: AppRouter().pop,
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
