import 'package:caeli/services/networking.dart';
import 'package:caeli/services/location.dart';
const apikey = '29a3c6e4e081b60c8d5f57a2a9dd4766';
const url = 'http://api.openweathermap.org/data/2.5/weather';

// const url1= 'https://meet.google.com/onn-vbrj-jsc';
class WeatherModel {
  Future<dynamic> getcityweather(String cityname) async {
    var cityurl = '$url?q=$cityname&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(cityurl);
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }
  Future<dynamic> getf(double lat, double lon) async {
    var oncallurl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=29a3c6e4e081b60c8d5f57a2a9dd4766&units=metric';
    NetworkHelper networkHelper = NetworkHelper(oncallurl);
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getcurrentlocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$url?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
