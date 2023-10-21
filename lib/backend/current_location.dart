import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation {
  String? address;

  Future getCurrentLocation() async {
    print('getCurrentLocation 1');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        address = 'Location permission denied.';
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      address = 'Location permission permanently denied.';
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(minutes: 6));

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      // apiKey: 'AIzaSyDutH2pi37uW2FKyzD06s-myx4nlyCyCMc',
    );

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      print('Live location data $placemark fdfdfdf');

      address ='${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';

      return placemark;
    } else {
      address = 'Address not found.';
    }
  }
}
