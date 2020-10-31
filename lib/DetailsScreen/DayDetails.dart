import 'package:flutter/material.dart';
import 'package:weatherapp/SearchScreen/SearchApi.dart';

import 'Property.dart';
import '../Utilities/Constants.dart';


class DayDetails extends StatelessWidget {
  final  dayDetailsProperties;
WeatherApi _weatherApi = new WeatherApi();
  DayDetails({@required this.dayDetailsProperties});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Image.network( _weatherApi.getUrl(dayDetailsProperties['weather'][0]['id'])),
              Text(
                dayDetailsProperties['temp']['day'].toString()+'°',
                style: kWhiteWeatherDay,
              ),
              Text(
                dayDetailsProperties['weather'][0]['main'],
                style: weatherStatus,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['temp']['min'].round().toString()+'°',
                        propertyHeading: 'Min. Temp',
                      ),
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['pressure'].toString()+' hpa',
                        propertyHeading: 'Pressure',
                      ),
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['clouds'].toString()+'%',
                        propertyHeading: 'Clouds',
                      )
                    ],
                  ),
                  Column(
                    children: [
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['temp']['max'].round().toString()+'°',
                        propertyHeading: 'Max. Temp',
                      ),
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['humidity'].toString(),
                        propertyHeading: 'Humidity',
                      ),
                      PaddedProperty(
                        propertyValue: dayDetailsProperties['speed'].toString()+'/hr',
                        propertyHeading: 'WindSpeed',

                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.08)),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Property(
                  propertyValue: dayDetailsProperties['temp']['morn'].round().toString()+'°',
                  propertyHeading: 'Morning',
                ),
                Property(
                  propertyValue: dayDetailsProperties['temp']['day'].round().toString()+'°',
                  propertyHeading: 'Day',
                ),
                Property(
                  propertyValue: dayDetailsProperties['temp']['eve'].round().toString()+'°',
                  propertyHeading: 'Evening',
                ),
                Property(
                  propertyValue: dayDetailsProperties['temp']['night'].round().toString()+'°',
                  propertyHeading: 'Night',
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}