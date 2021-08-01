import 'package:geolocator/geolocator.dart';

class Location
{
  double latitude , longitude;
  Position position;
  Future<void> getcurrentlocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();

      print("enabled $enabled"); // true

      final permission = await Geolocator.checkPermission();

      print("permission $permission"); // whileInUse
       position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (e)
    {
      print(e);
    }
  }
}