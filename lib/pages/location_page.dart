import 'package:floyer/helpers/distance_helper.dart';
import 'package:floyer/helpers/validation_helper.dart';
import 'package:floyer/models/coords.dart';
import 'package:floyer/pages/location_picker.dart';
import 'package:floyer/providers/profile_provider.dart';
import 'package:floyer/router.dart';
import 'package:floyer/utils/app_dialog.dart';
import 'package:floyer/widgets/app_text_field.dart';
import 'package:floyer/widgets/dialogs/create_profile.dart';
import 'package:floyer/widgets/dialogs/location_exist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _formKey = GlobalKey<FormState>();

  final _latController = TextEditingController();

  final _lngController = TextEditingController();

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final nearest = DistanceHelper.getNearestProfile(
        double.parse(_latController.text),
        double.parse(_lngController.text),
        context.read<ProfileProvider>().profiles,
      );

      if (nearest != null) {
        AppDialog().show(
          context,
          LocationExistDialog(nearest: nearest.name),
        );
        return;
      }

      AppDialog().show(
        context,
        CreateProfileDialog(
          latitude: double.parse(_latController.text),
          longitude: double.parse(_lngController.text),
        ),
      );
    }
  }

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
                "Enter latitude and longitude to create a new location.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                controller: _latController,
                labelText: "Latitude",
                validator: ValidationHelper.validateLatitude,
                digitsOnly: true,
                prefixIcon: const Icon(Icons.location_on_rounded),
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                controller: _lngController,
                labelText: "Longitude",
                validator: ValidationHelper.validateLongitude,
                digitsOnly: true,
                prefixIcon: const Icon(Icons.location_on_rounded),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () async {
                  final Coords? coords =
                      await AppRouter().push(const LocationPicker());
                  if (coords != null) {
                    _latController.text = coords.latitude.toString();
                    _lngController.text = coords.longitude.toString();
                  }
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_rounded),
                    SizedBox(width: 8.0),
                    Text("Pick Location from Map"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSubmit,
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
