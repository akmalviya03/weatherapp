import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = auth.currentUser;
    assert(user.uid == currentUser.uid);
    keepSession(user);
    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);
    keepSession(user);
    return user;
  }

  keepSession(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', user.uid);
  }

  Future<void> removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');
  }

}
