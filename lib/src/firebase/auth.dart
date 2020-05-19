import 'package:feather/src/firebase/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  Future<Response> signInWithEmailAndPassword(
      String emailId, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailId, password: password);
      return Response.success(authResult.user);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> sendVerificationLink(FirebaseUser user) async {
    try {
      await user.sendEmailVerification();
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  bool isEmailVerified(FirebaseUser user) => user.isEmailVerified;

  Future<Response> createUserWithEmailAndPassword(
      String emailId, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailId, password: password);
      return Response.success(authResult.user);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> sendPasswordResetEmail(String emailId) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> confirmPasswod(String oobCode, String emailId) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(oobCode, emailId);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }
}
