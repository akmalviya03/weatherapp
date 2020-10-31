import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Utilities/Constants.dart';
import 'package:weatherapp/SplashScreen.dart';
import 'LoginScreen/LoginScreenProvider.dart';
import 'SearchScreen/SearchAndSaveLocationProvider.dart';


//Firebase is Only Configured For Android.Please test this app on Android.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SaveAndSearchLocationProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: kVeryDarkBlue,
          iconTheme: IconThemeData(
            color: kYellow,
          ),
        )),
        home: SplashScreen(),
      ),
    ),
  );
}
