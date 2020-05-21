import 'package:feather/src/firebase/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  final FirebaseUser user;

  const AuthApi(this.user);

  static Future<Response<AuthApi>> get() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();
      if (user != null)
        return Response.success(AuthApi(user));
      else
        throw Error();
    } catch (e) {
      return Response.failure(e);
    }
  }

  static Future<Response<AuthApi>> signInWithEmailAndPassword(
      String emailId, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailId, password: password);
      return Response.success(AuthApi(authResult.user));
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> sendVerificationLink() async {
    try {
      await user.sendEmailVerification();
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  bool get isEmailVerified => user.isEmailVerified;

  static Future<Response<AuthApi>> createUserWithEmailAndPassword(
      String emailId, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailId, password: password);
      return Response.success(AuthApi(authResult.user));
    } catch (e) {
      return Response.failure(e);
    }
  }

  static Future<Response> sendPasswordResetEmail(String emailId) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  static Future<Response> confirmPasswod(String oobCode, String emailId) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(oobCode, emailId);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }
}
