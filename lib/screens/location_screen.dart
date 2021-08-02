import 'package:auto_size_text/auto_size_text.dart';
import 'package:caeli/services/networking.dart';
import 'package:flutter/material.dart';
// import 'package:caeli/utilities/constants.dart';
import 'package:caeli/services/weather.dart';
import 'city_screen.dart';
import 'package:caeli/screens/weatherforstcrust.dart';
import 'package:caeli/services/location.dart';
Polutiondata pol = Polutiondata();
Location loc =  Location();
class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherdata);
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int tempareture;
  String weathericon;
  String cityname;
  String massage;
  String des;
  String iiccoo;
  String backgroundimage;
  int min;
  int feel;
  int max;
  double flon ;
  double flat ;
  bool checker = true;
  Future<void> gcl() async {
    await loc.getcurrentlocation();
    setState(() {
      flon = loc.longitude;
      flat = loc.latitude;
    });
  }
  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherdata);
    gcl();
  }
  void updateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        checker = false;
        tempareture = 0;
        backgroundimage = 'error';
        weathericon = 'https://image.flaticon.com/icons/png/512/429/429886.png';
        cityname = 'Server';
        massage = 'Unexpected error occurs';
      } else {
        checker = true;
        flon = weatherdata['coord']['lon'].toDouble();
        flat = weatherdata['coord']['lat'].toDouble();
        double temp = weatherdata['main']['temp'].toDouble();
        tempareture = temp.toInt();
        massage = weather.getMessage(tempareture);
        // var condition = weatherdata['weather'][0]['id'];
        // weathericon = weather.getWeatherIcon(condition);
        weathericon = 'http://openweathermap.org/img/wn/${weatherdata['weather'][0]['icon']}@2x.png';
        iiccoo = weatherdata['weather'][0]['icon'];
        backgroundimage = iiccoo.substring(iiccoo.length - 1);
        // min = weatherdata['main']['temp_min'].toInt();
        // max = weatherdata['main']['temp_max'].toInt();
        feel = weatherdata ['main']['feels_like'].toInt();
        des = weatherdata['weather'][0]['description'];
        cityname = weatherdata['name'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(weatherpolutiondata['list'][0]['main']['aqi']);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.teal,
        // backgroundColor: Colors.green,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$backgroundimage.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.9), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getlocationweather();
                      flon = weatherdata['coord']['lon'];
                      flat = weatherdata['coord']['lat'];
                      updateUi(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //    print(backgroundimage); //TODO///////////////////////////////////////////////////
                  //   },
                  //   child: Icon(
                  //     Icons.find_in_page,
                  //     size: 50.0,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if( typedName != null)
                      {
                        var weatherfdata = await weather.getcityweather(typedName); //TODO:
                        updateUi(weatherfdata);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Expanded(child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.network('$weathericon',),
              // ),),
              Visibility(
                visible: checker==true?true:false,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 0,
                              child: AutoSizeText(
                                '$tempareture°C',
                                style:TextStyle(
                                  fontFamily: 'Spartan MB',
                                  fontSize: MediaQuery.of(context).size.width * 0.2,
                                ),
                                maxFontSize: 100,
                              ),
                            ),
                            // Text(
                            //   weathericon,
                            //   style: kConditionTextStyle,
                            // ),
                            Expanded(flex: 0, child: Image.network('$weathericon',)),
                          ],
                        ),
                        ListTile(
                          leading: Image.network('$weathericon'),
                          title: AutoSizeText(des,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,maxLines:1,),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Text('Max: $max°C',style: TextStyle(fontWeight: FontWeight.bold),),
                              // Text('Min: $min°C',style: TextStyle(fontWeight: FontWeight.bold),),
                              Text('Feels Like:',style: TextStyle(fontWeight: FontWeight.bold),),
                              Text('$feel°C',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: ()  async{
                              var weathrfdata = await weather.getf(flat, flon);
                              var polutionweatherdata = await pol.getp(flon, flat);
                              // print(polutionweatherdata['list'][0]['main']['aqi']);
                              // print(weathrfdata['current']['temp']);
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Weatherforstcrust(weathrfdata,polutionweatherdata);
                              },),);
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded( flex: 0,child: AutoSizeText('Weather Forecast',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
                                Icon(
                                  Icons.timelapse,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    // " djsago;fihgoih oihsdgouihog dgihaergoihaerg asdi9ghaweuioghad asdoghasdgoih ",
                    "$massage in $cityname!",
                    // maxLines:2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100.0,
                      fontFamily: 'Spartan MB',
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class Polutiondata
{
  Future<dynamic> getp(double lon, double lat) async
  {
    var polution = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=29a3c6e4e081b60c8d5f57a2a9dd4766';
    NetworkHelper networkHelper = NetworkHelper(polution);
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }
}