import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_marker_animation/core/ripple_marker.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project/Controllers/push_notification.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location locationController = Location();
  LatLng? _currentPosition;
  final Completer<GoogleMapController> googleMapCompleteController =
      Completer<GoogleMapController>();

  //to holds the ocationController.onLocationChanged.listen() so it can dispose after
  StreamSubscription<LocationData>? locationSubscription;

  bool? _isWithinRange;

  final Set<Polyline> _polyline = {};
  List<LatLng> latLen = [];

  @override
  void initState() {
    super.initState();
    getLocationData();
    checkRange();
    _polyline.add(Polyline(
      polylineId: PolylineId('1'),
      points: latLen,
      color: Colors.green,
    ));
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    googleMapCompleteController.future.then((controller) {
      controller.dispose();
    });
    super.dispose();
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
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                tilt: 59.440717697143555,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController mapController) {
                googleMapCompleteController.complete(mapController);
              },
              markers: {
                RippleMarker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  ripple: true,
                  position: _currentPosition!,
                ),
                Marker(
                  markerId: MarkerId('Medawachchiya'),
                  position: LatLng(8.5375, 80.4910),
                ),
                Marker(
                  markerId: MarkerId('ethakada'),
                  position: LatLng(8.6409, 80.6697),
                ),
              },
              polylines: _polyline,
            ),
    );
  }

  Future<void> checkRange() async {
    if (_currentPosition != null) {
      double s1 = Geolocator.distanceBetween(8.5375, 80.4910,
          _currentPosition!.latitude, _currentPosition!.longitude);
      double s2 = Geolocator.distanceBetween(8.6409, 80.6697,
          _currentPosition!.latitude, _currentPosition!.longitude);

      if (s1 > s2) {
        latLen.add(LatLng(8.6409, 80.6697));
      } else {
        latLen.add(LatLng(8.5375, 80.4910));
      }
    }
  }

  Future<void> getLocationData() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationSubscription = locationController.onLocationChanged.listen(
      (LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _currentPosition = LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            );
          });
        }
      },
      onError: (error) {},
    );
  }
}




// // ignore_for_file: prefer_const_constructors

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_map_marker_animation/core/ripple_marker.dart';
// import 'package:google_map_marker_animation/widgets/animarker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:project/Controllers/push_notification.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   // PushNotification _notification = new PushNotification();
//   Location locationController = new Location();
//   LatLng? _currentPosition;
//   final Completer<GoogleMapController> googleMapCompleteController =
//       Completer<GoogleMapController>();

//   bool? _isWithinRange;

//   final Set<Polyline> _polyline = {};
//   List<LatLng> latLen = [];

//   @override
//   void initState() {
//     super.initState();
//     //prevent update location continously
//     //locationSubscription = null;
//     getLocationData();
//     checkRange();
//     _polyline.add(Polyline(
//       polylineId: PolylineId('1'),
//       points: latLen,
//       color: Colors.green,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.abc),
//           onPressed: () {
//             print(_isWithinRange);
//           },
//         ),
//       ),
//       body: _currentPosition == null
//           ? Center(
//               child: Text("Loading...."),
//             )
//           : GoogleMap(
//               mapType: MapType.normal,
//               // myLocationButtonEnabled: true,
//               initialCameraPosition: CameraPosition(
//                   bearing: 192.8334901395799,
//                   target: LatLng(
//                       _currentPosition!.latitude, _currentPosition!.longitude),
//                   //target: LatLng(6.053519, 80.220978),
//                   tilt: 59.440717697143555,
//                   zoom: 15),
//               onMapCreated: (GoogleMapController mapController) {
//                 googleMapCompleteController.complete(mapController);
//               },
//               markers: {
//                 RippleMarker(
//                     markerId: MarkerId("_currentLocation"),
//                     icon: BitmapDescriptor.defaultMarker,
//                     ripple: true,
//                     position: _currentPosition!),
//                 Marker(
//                   markerId: MarkerId('Medawachchiya'),
//                   position: LatLng(8.5375, 80.4910),
//                 ),
//                 Marker(
//                   markerId: MarkerId('ethakada'),
//                   position: LatLng(8.6409, 80.6697),
//                 )
//               },
//               // circles: {
//               //   Circle(
//               //       circleId: CircleId("1"),
//               //       center: latLen[0],
//               //       radius: 800,
//               //       strokeWidth: 2,
//               //       fillColor: Colors.cyan.withOpacity(0.2)),
//               // },
//               polylines: _polyline,
//             ),
//     );
//   }

//   //checking nearest supermarket
//   Future<void> checkRange() async {
//     if (_currentPosition != null) {
//       double s1 = Geolocator.distanceBetween(8.5375, 80.4910,
//           _currentPosition!.latitude, _currentPosition!.longitude);
//       double s2 = Geolocator.distanceBetween(8.6409, 80.6697,
//           _currentPosition!.latitude, _currentPosition!.longitude);

//       if (s1 > s2) {
//         latLen.add(LatLng(8.6409, 80.6697));
//       } else {
//         latLen.add(LatLng(8.5375, 80.4910));
//       }
//     }
//   }

//   Future<void> getLocationData() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;

//     //checking weather location service is on
//     _serviceEnabled = await locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//     // requesting location permission
//     _permissionGranted = await locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     locationController.onLocationChanged.listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentPosition =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           // checkRange();
//         });
//       }
//     });
//   }
// }
