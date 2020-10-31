import 'package:flutter/material.dart';
import 'package:weatherapp/Utilities/Constants.dart';
import 'package:intl/intl.dart';
import 'DayDetails.dart';

class FullDetails extends StatelessWidget {
final fullDetailsProperties;
FullDetails({@required this.fullDetailsProperties});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kVeryDarkBlue,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: DateFormat.yMMMd()
                  .format(DateTime.fromMillisecondsSinceEpoch(
                  fullDetailsProperties['dt'] * 1000))
                  .toString(),
              child: Text(
                  " "+DateFormat.yMMMd()
                      .format(DateTime.fromMillisecondsSinceEpoch(
                      fullDetailsProperties['dt'] * 1000))
                      .toString(),
                  style: kTodayDateHeadingFullDetail),
            ),
            DayDetails(dayDetailsProperties: fullDetailsProperties,),
          ],
        ),
      ),
    );
  }
}
