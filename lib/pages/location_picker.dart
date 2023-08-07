import 'package:floyer/models/coords.dart';
import 'package:floyer/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final mapController = MapController();
  LatLng _lastLocation = const LatLng(51.509364, -0.128928);

  final String accessToken =
      "pk.eyJ1IjoidHVzaGE1NSIsImEiOiJja2lrODd0cXkwN2FhMzFveXFkbmZkcXh6In0.9QFXVozLHDr09C7q-LyWyw";

  void setLastLocation(LatLng location) {
    setState(() {
      _lastLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: AppRouter().pop,
          icon: const Icon(Icons.keyboard_backspace_rounded),
        ),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: const LatLng(51.509364, -0.128928),
          zoom: 14,
          maxZoom: 18,
          minZoom: 4,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onPositionChanged: (position, hasGesture) {
            setLastLocation(position.center!);
          },
        ),
        nonRotatedChildren: [
          const RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors'),
              TextSourceAttribution('MapBox contributors'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: kToolbarHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => AppRouter().pop(
                  Coords(
                    latitude: _lastLocation.latitude,
                    longitude: _lastLocation.longitude,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(
                    MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "CONFIRM",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_lastLocation.latitude.toStringAsFixed(2)}, ${_lastLocation.longitude.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 48.0),
              child: Icon(
                Icons.location_pin,
                size: 48,
              ),
            ),
          ),
        ],
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/tusha55/ckilggvjg0aju17lnsm7771uf/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken',
            additionalOptions: {
              'id': 'mapbox.mapbox-streets-v8',
              "accessToken": accessToken,
            },
            subdomains: const ['a', 'b', 'c'],
          ),
          CurrentLocationLayer(
            followOnLocationUpdate: FollowOnLocationUpdate.once,
            turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
          ),
        ],
      ),
    );
  }
}
