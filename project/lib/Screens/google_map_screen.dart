// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location locationController = new Location();
  LatLng? _currentPosition;
  final Completer<GoogleMapController> googleMapCompleteController =
      Completer<GoogleMapController>();
  bool? _isWithinRange;
  //late StreamSubscription<LocationData>? locationSubscription;
  @override
  void initState() {
    super.initState();
    //prevent update location continously
    //locationSubscription = null;
    getLocationData();
    //checkRange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.abc),
            onPressed: () {
              print(_isWithinRange);
            },
          ),
        ),
        body: _currentPosition == null
            ? Center(
                child: Text("Loading...."),
              )
            : GoogleMap(
                mapType: MapType.normal,
                // myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    //target: LatLng(6.053519, 80.220978),
                    tilt: 59.440717697143555,
                    zoom: 15),
                onMapCreated: (GoogleMapController mapController) {
                  googleMapCompleteController.complete(mapController);
                },
                markers: {
                  Marker(
                      markerId: MarkerId("_currentLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _currentPosition!)
                },
              ));
  }

  Future<void> checkRange() async {
    if (_currentPosition != null) {
      double d = Geolocator.distanceBetween(6.053519, 80.220978,
          _currentPosition!.latitude, _currentPosition!.longitude);

      setState(() {
        if (d < 100000) {
          _isWithinRange = true;
        } else {
          _isWithinRange = false;
        }
      });
    }
  }

  Future<void> getLocationData() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //checking weather location service is on
    _serviceEnabled = await locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // requesting location permission
    _permissionGranted = await locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          checkRange();
        });
      }
    });
    // locationSubscription = locationController.onLocationChanged
    //     .listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     setState(() {
    //       _currentPosition =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //     });
    //     print(currentLocation);
    //   }
    // });
  }
}
