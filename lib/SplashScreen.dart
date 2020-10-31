import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/Utilities/Constants.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'LoginScreen/LoginScreen.dart';
import 'SearchScreen/SearchLocation.dart';
import 'TransitionAnimation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String uid;
  @override
  void initState() {
    super.initState();
    pushToPageView();
  }

  void checkLoggedInOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userToken');
  }

  pushToPageView() async {
    checkLoggedInOrNot();
    Timer(Duration(seconds: 2), onBoardingPath);
  }

  void onBoardingPath() {
    uid !=null?
    Navigator.pushReplacement(context,
      SizeRoute( page: SearchAndSaveLocation(uid: uid,))
    ): Navigator.push(context, SizeRoute(page: LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kVeryDarkBlue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WebsafeSvg.asset(
                  'assets/svgs/logo-weather-app.svg',
                  width: MediaQuery.of(context).size.width*0.5
              ),
              Text('Weather App',style:kSplashScreenAppName)
            ],
          ),
        ),
      ),
    );
  }
}


