import 'package:feather/src/firebase/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  final FirebaseUser user;

  AuthApi(this.user);

  static Future<Response<AuthApi>> get() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if (user != null)
        return Response.success(AuthApi(user));
      else
        throw Error();
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> reload() async {
    try {
      await user.reload();
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> updateProfile(String displayName) async {
    try {
      await user.updateProfile(UserUpdateInfo()..displayName = displayName);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  String get displayName => user.displayName;

  static Future<Response> sendVerificationLink(String emailId) async {
    try {
      await FirebaseAuth.instance.sendSignInWithEmailLink(
        email: emailId,
        url: 'https://feather.brokenglass.com/login',
        handleCodeInApp: true,
        iOSBundleID: '',
        androidMinimumVersion: '12',
        androidPackageName: 'com.brokenglass.feather',
        androidInstallIfNotAvailable: true,
      );
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }
}
