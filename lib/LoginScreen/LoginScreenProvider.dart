import 'package:flutter/cupertino.dart';

class LoginScreenProvider with ChangeNotifier{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _validateEmail = false;
  bool _validatePassword = false;

  updateValidateEmail(bool val){
    _validateEmail = val;
    notifyListeners();
  }
  updateValidatePassword(bool val){
    _validatePassword = val;
    notifyListeners();
  }
  getValidateEmail(){
    return _validateEmail;
  }

  getValidatePassword(){
    return _validatePassword;
  }

  getEmailController(){
    return _emailController;
  }

  getPasswordController(){
    return _passwordController;
  }
  disposeEmailController(){
    return _emailController.dispose();
  }
  disposePasswordController(){
    return _passwordController.dispose();
  }
}