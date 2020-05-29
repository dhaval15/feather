import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase/firebase.dart';

class Provider extends StatefulWidget {
  final DatabaseFactory factory;
  final Widget child;
  Provider({Key key, this.child, this.factory}) : super(key: key);

  static _ProviderState of(BuildContext context) =>
      context.findAncestorStateOfType<_ProviderState>();

  @override
  _ProviderState createState() => _ProviderState();

  static Future<FirebaseUser> getCurrentUser() =>
      FirebaseAuth.instance.currentUser();
}

class _ProviderState extends State<Provider> {
  FirebaseUser user;
  StreamSubscription _subscription;
  Function(FirebaseUser) onAuthStateChanged;
  SharedPreferences preferences;
  SembastApi featherApi;

  void setOnAuthStateChanged(Function(FirebaseUser) onAuthStateChanged) {
    this.onAuthStateChanged = onAuthStateChanged;
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPreference();
    _subscription = FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      this.user = user;
      onAuthStateChanged(user);
    });
    featherApi = SembastApi(widget.factory);
    featherApi.init();
  }

  void _loadSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    featherApi.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<Response> sendVerificationLink(String emailId) async {
    try {
      await FirebaseAuth.instance.sendSignInWithEmailLink(
        email: emailId,
        url: 'https://feather-bg.firebaseapp.com',
        handleCodeInApp: true,
        iOSBundleID: '',
        androidMinimumVersion: '0',
        androidPackageName: 'com.brokenglass.feather',
        androidInstallIfNotAvailable: true,
      );
      return Response.success(true);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> verifyEmailLink(String emailId, String link,
      {String name}) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndLink(email: emailId, link: link);
      if (name != null)
        result.user.updateProfile(UserUpdateInfo()..displayName = name);
      return Response.success(result);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future<Response> isFirstTime(String emailId) async {
    try {
      final methods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email: emailId);
      return Response.success(methods.length == 0);
    } catch (e) {
      return Response.failure(e);
    }
  }

  void storeEmailId(String emailId) =>
      preferences.setString('EMAIL_ID', emailId);

  void storeName(String name) => preferences.setString('NAME', name);

  String fetchEmailId() => preferences.getString('EMAIL_ID');
  String fetchName() => preferences.getString('NAME');
}
