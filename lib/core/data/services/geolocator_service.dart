// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class GeoLocatorService{

//   Future<bool> requestPermission() async {
//     final status = await Permission.locationWhenInUse.request();
//     return status.isGranted;
//   }

//   Future<Position?> getCurrentLocation() async {
//     final hasPermission = await Permission.locationWhenInUse.status.isGranted ||
//         await requestPermission();

//     if (!hasPermission) {
//       return null;
//     }

//     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return null;
//     }

//     const LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//     );

//     final position = await Geolocator.getCurrentPosition(
//         locationSettings: locationSettings
//     );

//     return position;
//   }
// }