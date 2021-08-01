// import 'package:caeli/services/networking.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:caeli/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Weatherforstcrust extends StatefulWidget {
  Weatherforstcrust(this.weatherdata, this.weatherpolutiondata);

  final Map<String, dynamic> weatherdata;
  final Map<String, dynamic> weatherpolutiondata;
  @override
  _WeatherforstcrustState createState() => _WeatherforstcrustState();
}

class _WeatherforstcrustState extends State<Weatherforstcrust> {
  var weatherforcustdata;
  var wpd;
  var mTextstyle;
  String massages;
  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherdata, widget.weatherpolutiondata);
    msg();
    // gcl();
  }

  void updateUi(dynamic weatherdata, dynamic weatherpolutiondata) {
    setState(() {
      weatherforcustdata = weatherdata;
      wpd = weatherpolutiondata;
    });
  }

  void msg() // Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
  {
    if (wpd['list'][0]['main']['aqi'] == 1) {
      massages = 'Good';
      mTextstyle = TextStyle(
        color: Colors.white38,
        fontSize: 30.0,
        fontFamily: 'Spartan MB',
      );
    } else if (wpd['list'][0]['main']['aqi'] == 2) {
      massages = 'Fair';
      mTextstyle = TextStyle(
        color: Colors.white38,
        fontSize: 30.0,
        fontFamily: 'Spartan MB',
      );
    } else if (wpd['list'][0]['main']['aqi'] == 3) {
      massages = 'Moderate';
      mTextstyle = TextStyle(
        fontSize: 30.0,
        color: Colors.white38,
        fontFamily: 'Spartan MB',
      );
    } else if (wpd['list'][0]['main']['aqi'] == 4) {
      massages = 'Poor';
      mTextstyle = TextStyle(
        color: Colors.white38,
        fontSize: 30.0,
        fontFamily: 'Spartan MB',
      );
    } else if (wpd['list'][0]['main']['aqi'] == 5) {
      massages = 'Very Poor';
      mTextstyle = TextStyle(
        color: Colors.white38,
        fontSize: 30.0,
        fontFamily: 'Spartan MB',
      );
    }
  }
  _launchURL() async {
    const url = 'https://www.linkedin.com/in/deep-choudhury-239aa0195/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  ListTile getlistdata(int index) {
    return ListTile(
      // tileColor: Colors.green,
      title: AutoSizeText(
        '${DateFormat("EEE, MMM d").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['daily'][index]['dt'] + (weatherforcustdata['timezone_offset']) -19800) * 1000))}, ${weatherforcustdata['daily'][index]['weather'][0]['description']}',
        // overflow: TextOverflow.fade,
        maxLines: 1,
        textAlign: TextAlign.start,
      ),
      subtitle: Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              'Day: ${weatherforcustdata['daily'][index]['temp']['day'].toInt()} °C    '), //daily[0].temp.day
          Text(
              'Night: ${weatherforcustdata['daily'][index]['temp']['night'].toInt()}  °C '),
        ],
      ),
      leading: Image.network(
          'http://openweathermap.org/img/wn/${weatherforcustdata['daily'][index]['weather'][0]['icon']}@2x.png'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
              'Max: ${weatherforcustdata['daily'][index]['temp']['max'].toInt()}°C '),
          Text(
              'Min: ${weatherforcustdata['daily'][index]['temp']['min'].toInt()}°C '),
        ],
      ),
    );
  }

  ListTile getpoldata(String shortcut, String fullname, String data) {
    return ListTile(
      leading: Text(
        '$shortcut',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 19.0),
      ),
      title: Text(
        '$fullname',
      ),
      trailing: Text(
          '${wpd['list'][0]['components']['$data']}  μg/m3'), //list[0].components.co
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         //timezone_offset
                  //         // print(DateFormat("dd-MM-yyyy HH:MM:SS aaa").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['hourly'][0]['dt'] + (weatherforcustdata['timezone_offset'])) * 1000)));
                  //         var datetime = DateFormat("dd-MM-yyyy hh:mm: aaa").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['hourly'][0]['dt'] + (weatherforcustdata['timezone_offset']) -19800) * 1000));
                  //         var dt = datetime;
                  //         print(dt);
                  //         var sunrise = DateFormat("dd-MM-yyyy hh:mm: aaa").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['daily'][0]['sunrise'] + (weatherforcustdata['timezone_offset']) - 19800) * 1000));             ///daily[0].sunrise
                  //         var sunset = DateFormat("dd-MM-yyyy hh:mm: aaa").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['daily'][0]['sunset'] + (weatherforcustdata['timezone_offset']) -19800) * 1000));             ///daily[0].sunrise
                  //         print(sunrise);
                  //         print (sunset);
                  //       });
                  //     },
                  //     child: Icon(

                  //       Icons.adjust_rounded,
                  //       color: Colors.white,
                  //       size: 50.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Text(
                          'Air Quality is',
                          style: kButtonTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$massages ',
                          style: mTextstyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.blue.shade300,
                      thickness:1.89 ,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5,left: 5,right: 5),
                    child: Center(
                      child: (AutoSizeText(
                        'Hourly Forecast',
                        maxLines: 1,
                        style: kButtonTextStyle,
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  Container(
                    height: 120.0,
                    //color: Colors.red,
                    child: ListView.builder(
                      itemCount: 24,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          // color: Colors.red,
                          width: 155,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                    'http://openweathermap.org/img/wn/${weatherforcustdata['hourly'][index]['weather'][0]['icon']}@2x.png'),
                              ), //hourly[0].weather[0].icon
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Center(
                                  child: Text(
                                    '${weatherforcustdata['hourly'][index]['temp'].toInt()}°C',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ), //
                              ), //hourly[0].temp
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${weatherforcustdata['hourly'][index]['weather'][0]['description']}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ), //
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Center(
                                    child: Text(
                                  '${DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['hourly'][index]['dt'] + (weatherforcustdata['timezone_offset']) -19800) * 1000))}', //TODO
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ], //DateFormat("dd-MM-yyyy hh:mm:ss aaa").format(DateTime.fromMillisecondsSinceEpoch((weatherforcustdata['hourly'][0]['dt'] + (weatherforcustdata['timezone_offset'])) * 1000))
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.blue.shade300,
                      thickness:1.89 ,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: AutoSizeText(
                      'Daily Forecast',
                      maxLines: 1,
                      style: kButtonTextStyle,
                    ),
                  ),
//                   Container(
//                     height: 350,
// //color: Colors.red,
//                     child: ListView.builder(
//                       itemCount: 7,
// // scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return ListTile(
// // tileColor: Colors.green,
//                           title: Text(
//                             'Day ${index + 1} , ${weatherforcustdata['daily'][index]['weather'][0]['description']}',
//                             overflow: TextOverflow.fade,
//                             textAlign: TextAlign.start,
//                           ),
//                           subtitle: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                       'Day: ${weatherforcustdata['daily'][index]['temp']['day'].toInt()} °C    '), //daily[0].temp.day
//                                   Text(
//                                       'Night: ${weatherforcustdata['daily'][index]['temp']['night'].toInt()}  °C '),
//                                 ],
//                               )
//                             ],
//                           ),
//                           leading: Image.network(
//                               'http://openweathermap.org/img/wn/${weatherforcustdata['daily'][index]['weather'][0]['icon']}@2x.png'),
//                           trailing: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
// // crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                   'Max: ${weatherforcustdata['daily'][index]['temp']['max'].toInt()}°C '),
//                               Text(
//                                   'Min: ${weatherforcustdata['daily'][index]['temp']['min'].toInt()}°C '),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
                  getlistdata(0),
                  getlistdata(1),
                  getlistdata(2),
                  getlistdata(3),
                  getlistdata(4),
                  getlistdata(5),
                  getlistdata(6),
                  getlistdata(7),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.blue.shade300,
                      thickness:1.89 ,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30.0, top: 10.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: [
                        AutoSizeText(
                          'Weather Pollutant Details',
                          maxLines: 1,
                          style: kButtonTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        getpoldata('CO', 'Carbon monoxide', 'co'),
                        getpoldata('NO', 'Nitrogen monoxide', 'no'),
                        getpoldata('NO2', 'Nitrogen dioxide', 'no2'),
                        getpoldata('O3', 'Ozone', 'o3'),
                        getpoldata('SO2', 'Sulphur dioxide', 'so2'),
                        getpoldata('NH3', 'Ammonia', 'nh3'),
                        getpoldata('PM2.5', 'Fine particles matter', 'pm2_5'),
                        getpoldata('PM10', 'Coarse particulate matter', 'pm10'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 35.0, top: 10.0, left: 5.0, right: 5.0),
                    child: GestureDetector(
                      onTap: _launchURL,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:10 ),
                            child: CircleAvatar(
                              //backgroundImage: ,
                              backgroundColor: Colors.white38,
                              radius: 25.0,
                              backgroundImage: AssetImage('images/my.jpg'),
                            ),
                          ),
                          Text(
                            'Developed by Deep Choudhury',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            width: 100,
                            child: Divider(
                              color: Colors.blue.shade300,
                              thickness:1.89 ,
                            ),
                          ),
                          Text(
                            'Flutter Developer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
