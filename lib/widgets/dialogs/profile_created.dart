import 'package:floyer/pages/home/home_page.dart';
import 'package:floyer/router.dart';
import 'package:flutter/material.dart';

class ProfileCreatedDialog extends StatelessWidget {
  const ProfileCreatedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text("Success"),
        content: const Text("Profile created successfully."),
        actions: [
          TextButton(
            onPressed: () => AppRouter().pushAndRemoveUntil(const HomePage()),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
