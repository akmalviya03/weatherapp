import 'package:flutter/material.dart';
import 'package:weatherapp/SearchScreen/SearchApi.dart';
import 'package:weatherapp/Utilities/Constants.dart';
import 'package:intl/intl.dart';
import 'DayDetails.dart';
import 'Property.dart';
import 'FullDetailsScreen.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic weatherData;

  DetailsScreen({@required this.weatherData});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  WeatherApi _weatherApi = new WeatherApi();
  @override
  Widget build(BuildContext context) {
    print(widget.weatherData['list'][0]);
    var today = widget.weatherData['list'][0];
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kVeryDarkBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag:widget.weatherData['city']['name'],
                        child: Text(widget.weatherData['city']['name'],
                            style: kDetailsCityName),
                      ),
                      Text(
                          " "+DateFormat.yMMMd()
                              .format(DateTime.fromMillisecondsSinceEpoch(
                              today['dt'] * 1000))
                              .toString(),
                          style: kTodayDate)
                    ],
                  ),
                ),
                DayDetails(dayDetailsProperties: today,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: EdgeInsets.only(left:16,right: 16),
                        decoration: BoxDecoration(
                            color: kBlue,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.08)),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => FullDetails(
                                            fullDetailsProperties: widget.weatherData['list'][index+1],
                                          )));
                                },
                                child: Text(
                                  'View Details',
                                  style: kYellowBody,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(_weatherApi.getUrl(widget.weatherData['list'][index+1]['weather'][0]['id']),width: MediaQuery.of(context).size.width*0.1,),
                                    Hero(
                                      tag:DateFormat.yMMMd()
                                          .format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.weatherData['list'][index+1]['dt'] * 1000))
                                          .toString() ,
                                      child: Text(DateFormat.yMMMd()
                                          .format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.weatherData['list'][index+1]['dt'] * 1000))
                                          .toString(), style: kTodayDate),
                                    ),
                                  ],
                                ),
                                Property(
                                  propertyValue: widget.weatherData['list'][index+1]['temp']['max'].round().toString()+'°',
                                  propertyHeading: 'Maximum',

                                ),
                                Property(
                                  propertyValue: widget.weatherData['list'][index+1]['temp']['min'].round().toString()+'°',
                                  propertyHeading: 'Minimum',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}





