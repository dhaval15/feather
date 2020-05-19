import 'package:flutter/material.dart';
import 'firebase/firebase.dart';

class Provider extends StatelessWidget {
  final Widget child;
  final AppState state = AppState();

  Provider({Key key, this.child}) : super(key: key);

  factory Provider.of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<Provider>();

  @override
  Widget build(BuildContext context) => child;
}

class AppState {
  AuthApi auth;
  FirebaseApi database;
  CollectionStore collectionStore;
  NoteStore noteStore;

  void init(AuthApi auth) {
    this.auth = auth;
    database = FirebaseApi.ofUser(auth.user);
    collectionStore = CollectionStore.of(auth.user);
    noteStore = NoteStore.of(auth.user);
  }
}
