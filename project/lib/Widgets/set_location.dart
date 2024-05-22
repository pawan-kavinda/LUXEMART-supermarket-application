import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({Key? key}) : super(key: key);

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  Location locationController = Location();
  LatLng? _currentPosition;
  GoogleMapController? _googleMapController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  Future<void> getLocationData() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Checking whether location service is on
    _serviceEnabled = await locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Requesting location permission
    _permissionGranted = await locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await locationController.getLocation();
    setState(() {
      _currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 400, // Set a specific height for the Google Map
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: _currentPosition!,
                        draggable: true,
                      ),
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your location set logic here
                  },
                  child: Text("Set Location"),
                ),
              ],
            ),
    );
  }
}
