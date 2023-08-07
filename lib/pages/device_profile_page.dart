import 'package:floyer/helpers/color_conveter.dart';
import 'package:floyer/models/coords.dart';
import 'package:floyer/models/device_profile.dart';
import 'package:floyer/pages/home/home_page.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:floyer/router.dart';
import 'package:floyer/utils/app_dialog.dart';
import 'package:floyer/widgets/app_text_field.dart';
import 'package:floyer/widgets/dialogs/profile_created.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceProfilePage extends StatefulWidget {
  const DeviceProfilePage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  State<DeviceProfilePage> createState() => _DeviceProfilePageState();
}

class _DeviceProfilePageState extends State<DeviceProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _seedColorController = TextEditingController();
  final _titleSizeController = TextEditingController();
  final _activeRadiusController = TextEditingController(text: "1000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: AppRouter().pop,
          icon: const Icon(Icons.keyboard_backspace_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create a new device profile by entering a name and other required details.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _nameController,
                labelText: "Profile Name",
                prefixIcon: const Icon(Icons.devices_rounded),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a name.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _seedColorController,
                labelText: "Seed Color",
                prefixIcon: Icon(
                  Icons.color_lens_rounded,
                  color: _seedColorController.text.isNotEmpty
                      ? ColorConverter().hexToColor(_seedColorController.text)
                      : null,
                ),
                readOnly: true,
                onTap: () async {
                  final color = await showModalBottomSheet(
                    enableDrag: false,
                    context: context,
                    builder: (context) => SizedBox(
                      height: 80,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        padding: const EdgeInsets.all(16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final color = Colors.primaries[index];
                          return GestureDetector(
                            onTap: () => AppRouter()
                                .pop(ColorConverter().colorToHex(color)),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                        itemCount: Colors.primaries.length,
                      ),
                    ),
                  );

                  if (color != null) {
                    setState(() {
                      _seedColorController.text = color;
                    });
                  }
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a seed color.";
                  }
                  if (text.length != 6) {
                    return "Seed color must be 6 characters long.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Font Sizes"),
              const SizedBox(height: 8),
              AppTextField(
                controller: _titleSizeController,
                labelText: "App Bar Title Size",
                prefixIcon: const Icon(Icons.text_fields_rounded),
                digitsOnly: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a font size.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Config"),
              const SizedBox(height: 8),
              AppTextField(
                controller: _activeRadiusController,
                labelText: "Activation Radius (in Meters)",
                prefixIcon: const Icon(Icons.my_location_rounded),
                digitsOnly: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a radius.";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveProfile,
        disabledElevation: 0,
        child: const Icon(Icons.check_rounded),
      ),
    );
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final profile = DeviceProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        colorSchemeSeed: _seedColorController.text,
        appBarTitleSize: double.parse(_titleSizeController.text),
        activationRadius: int.tryParse(_activeRadiusController.text) ?? 1000,
        coordinates: Coords(
          latitude: widget.latitude,
          longitude: widget.longitude,
        ),
      );

      await context.read<ProfileProvider>().addProfile(profile);

      if (mounted) {
        AppDialog().show(
          context,
          const ProfileCreatedDialog(),
        );
      } else {
        AppRouter().pushAndRemoveUntil(const HomePage());
      }
    }
  }
}
