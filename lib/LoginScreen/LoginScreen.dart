import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/LoginScreen/LoginApi.dart';
import 'package:weatherapp/TransitionAnimation.dart';

import '../Utilities/Constants.dart';
import '../SearchScreen/SearchLocation.dart';
import 'LoginScreenProvider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginApi _loginApi = new LoginApi();

  @override
  Widget build(BuildContext context) {
    var providerLogin =
        Provider.of<LoginScreenProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: kVeryDarkBlue,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Hello!",
                            style: GoogleFonts.montserrat(
                                fontSize: 36,
                                color: kRed,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: kYellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        Consumer<LoginScreenProvider>(
                            builder: (context, loginScreenProvider, child) {
                          return Column(
                            children: [
                              TextFormField(
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
                                  hintText: 'abhishek@webority.com',
                                  hintStyle: kGreyBody,
                                  errorText:
                                      loginScreenProvider.getValidateEmail()
                                          ? 'Phone enter your email id'
                                          : null,
                                ),
                                controller:
                                    loginScreenProvider.getEmailController(),
                              ),
                              TextFormField(
                                obscureText: true,
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
                                  hintText: '*******',
                                  hintStyle: kGreyBody,
                                  errorText:
                                      loginScreenProvider.getValidatePassword()
                                          ? 'Please enter your Password'
                                          : null,
                                ),
                                controller:
                                    loginScreenProvider.getPasswordController(),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text("LOGIN"),
                            textColor: kBlue,
                            padding: EdgeInsets.all(16),
                            onPressed: () async {
                              if (!providerLogin
                                      .getEmailController()
                                      .text
                                      .isEmpty &&
                                  !providerLogin
                                      .getEmailController()
                                      .text
                                      .isEmpty) {
                                User _user = await _loginApi.handleSignInEmail(
                                    providerLogin.getEmailController().text,
                                    providerLogin.getPasswordController().text);

                                if (_user.email != null) {
                                  providerLogin.updateValidateEmail(false);
                                  providerLogin.updateValidatePassword(false);
                                  Navigator.pushReplacement(
                                      context,
                                      SizeRoute(
                                          page: SearchAndSaveLocation(
                                        uid: _user.uid,
                                      )));
                                }
                              } else {
                                providerLogin.updateValidateEmail(true);
                                providerLogin.updateValidatePassword(true);
                              }
                            },
                            color: kYellow,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
