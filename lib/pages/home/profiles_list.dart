import 'package:floyer/constants/app_constants.dart';
import 'package:floyer/helpers/color_conveter.dart';
import 'package:floyer/models/device_profile.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilesList extends StatelessWidget {
  const ProfilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, pp, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Active Profile"),
              const SizedBox(height: 4),
              ProfileTile(profile: pp.currentProfile),
              const SizedBox(height: 16),
              const Text("All Profiles"),
              const SizedBox(height: 4),
              pp.profiles.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          "No profiles added yet.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final profile = pp.profiles[index];
                          return ProfileTile(profile: profile);
                        },
                        itemCount: pp.profiles.length,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.profile,
  });

  final DeviceProfile profile;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        title: Text(profile.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: "Seed Color: ",
                children: [
                  TextSpan(
                    text: "#${profile.colorSchemeSeed}",
                    style: TextStyle(
                      color: ColorConverter().hexToColor(
                        profile.colorSchemeSeed,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (profile.id != AppConstants.fallbackProfile.id)
              Row(
                children: [
                  Chip(
                    label: Text(
                      "Latitude: ${profile.coordinates.latitude.toStringAsFixed(2)}",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(
                      "Longitude: ${profile.coordinates.longitude.toStringAsFixed(2)}",
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
