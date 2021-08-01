
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:caeli/services/weather.dart';

// WeatherModel getweather = WeatherModel();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
    @override
    void initState() {
      super.initState();
      getlocationdata();
    }
  void getlocationdata() async {
   var weatherdata = await WeatherModel().getlocationweather();

   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LocationScreen(weatherdata)), (route) => false);
   //TODO// IMPORTANT Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return LocationScreen(weatherdata);
    //     },
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Center(
                child: SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Center(
                child: Text('Turn off battery sever mode if it is on \nOther wise app will not work',textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
