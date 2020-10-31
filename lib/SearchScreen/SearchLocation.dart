import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/LoginScreen/LoginApi.dart';
import 'package:weatherapp/LoginScreen/LoginScreen.dart';
import 'package:weatherapp/SearchScreen/SearchApi.dart';
import '../Utilities/Constants.dart';
import '../DetailsScreen/DetailsScreen.dart';
import 'SearchAndSaveLocationProvider.dart';
import 'firestoreApi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchAndSaveLocation extends StatefulWidget {
  final String uid;
  SearchAndSaveLocation({@required this.uid});
  @override
  _SearchAndSaveLocationState createState() => _SearchAndSaveLocationState();
}

class _SearchAndSaveLocationState extends State<SearchAndSaveLocation> {
  WeatherApi _weatherApi = new WeatherApi();
  FirestoreApi _firestoreApi = new FirestoreApi();
  LoginApi _loginApi = LoginApi();

  @override
  Widget build(BuildContext context) {
    var providerSearchAndSave =
        Provider.of<SaveAndSearchLocationProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kVeryDarkBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 1,
              height: size.height * 0.2,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment
                      .topRight, // 10% of the width, so there are ten blinds.
                  colors: [
                    kYellow,
                    kVeryDarkBlue,
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(size.width * 0.2),
                  bottomRight: Radius.zero,
                ),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: Text(
                      'Search',
                      style: kWhiteSearchBack,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Search',
                      style: kWhiteSearchFront,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      child: Text(
                        'Logout',
                        style: kRedBodyLogout,
                      ),
                      onPressed: () {
                        _loginApi.removeSession();
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()));
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                size.width * 0.05,
              ),
              child: Consumer<SaveAndSearchLocationProvider>(
                  builder: (context, saveAndSearchLocationProvider, child) {
                return TextFormField(
                  style: kYellowBody,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hoverColor: Colors.brown,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kYellow),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kYellow),
                    ),
                    hintText: 'New Delhi',
                    labelText: 'City Name',
                    labelStyle: kYellowBody,
                    hintStyle: kGreyBody,
                    errorText: saveAndSearchLocationProvider.getValidateSearch()
                        ? 'Please enter a city name'
                        : null,
                  ),
                  controller:
                      saveAndSearchLocationProvider.getSearchController(),
                );
              }),
            ),
            FlatButton(
              child: Text(
                'Get Weather',
                style: kVeryDarkBlueBody,
              ),
              color: kYellow,
              onPressed: () async {
                if (!providerSearchAndSave
                    .getSearchController()
                    .text
                    .isEmpty) {
                  providerSearchAndSave.updateValidateSearch(false);
                  var weatherData = await _weatherApi.getCityWeather(
                      providerSearchAndSave
                          .getSearchController()
                          .text
                          .toLowerCase());
                  if (weatherData != null) {

                    _firestoreApi.addAddressDocument(
                        cityName: weatherData['city']['name'],uid: widget.uid);
                    providerSearchAndSave.clearSearchController();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsScreen(
                          weatherData: weatherData,
                        ),
                      ),
                    );
                  }
                } else {
                  providerSearchAndSave.updateValidateSearch(true);
                }
              },
            ),
            StreamBuilder(
              stream: _firestoreApi.getCityDocuments(widget.uid),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.documents.length != 0) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                top: size.width * 0.05,
                              ),
                              child: Text(
                                'Recent Searches',
                                style: kWhiteRecentSearch,
                              )),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kBlue,
                                      borderRadius: BorderRadius.circular(size.width*0.05)
                                    ),
                                    margin: EdgeInsets.all(
                                      size.width * 0.03,
                                    ),
                                    padding: EdgeInsets.all(
                                      size.width * 0.03,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.width * 1,

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Hero(
                                          tag: snapshot
                                              .data.documents[index]['City']
                                              .toString(),
                                          child: Text(
                                            snapshot
                                                .data.documents[index]['City']
                                                .toString(),
                                            style: kSearchLocationCityName,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete_rounded,
                                              color: kRed,
                                            ),
                                            onPressed: () {
                                              _firestoreApi.deleteCityDocument(
                                                  cityName: snapshot.data
                                                      .documents[index]['City']
                                                      .toString(),uid: widget.uid);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    var weatherData = await _weatherApi
                                        .getCityWeather(snapshot
                                            .data.documents[index]['City']
                                            .toString());
                                    if (weatherData != null) {
                                      providerSearchAndSave
                                          .clearSearchController();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DetailsScreen(
                                                    weatherData: weatherData,
                                                  )));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Go Ahead and Search!',
                          textAlign: TextAlign.center,
                          style: kWhiteSearchFront,
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
