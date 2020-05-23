import 'package:feather/src/firebase/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  Future<Response> sendVerificationLink(String emailId) async {
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
