import 'package:flutter/material.dart';
import 'package:caeli/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}
String cityname;
class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: Container(

        decoration: BoxDecoration(
            //resizeToAvoidBottomInset: false;

          image: DecorationImage(
            // matchTextDirection: true,

            image: AssetImage('images/p.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
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
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextformfilledinputdecoration,
                onChanged: (value)
                  {
                    cityname = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityname);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
