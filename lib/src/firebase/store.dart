import 'dart:async';
import '../models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'refs.dart';
import 'utils.dart';

abstract class FirebaseStore<T> {
  final IndexedMap<String, T> _data = IndexedMap();
  final String _userId;
  final List<StreamSubscription> _subscriptions = [];
  final StreamController<Iterable<T>> _controller = StreamController();
  FirebaseStore._(this._userId);
  DatabaseReference get reference;

  T convert(dynamic json);

  void init() {
    _subscriptions.add(reference.onChildAdded.listen(_onChildAdded));
    _subscriptions.add(reference.onChildRemoved.listen(_onChildRemoved));
    _subscriptions.add(reference.onChildChanged.listen(_onChildChanged));
  }

  void _onChildAdded(Event e) {
    _data[e.snapshot.key] = convert(e.snapshot.value);
    _controller.add(_data.values);
  }

  void _onChildRemoved(Event e) {
    _data[e.snapshot.key] = null;
    _controller.add(_data.values);
  }

  void _onChildChanged(Event e) {
    _data[e.snapshot.key] = convert(e.snapshot.value);
    _controller.add(_data.values);
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _controller.close();
  }
}

class CollectionStore extends FirebaseStore<Collection> {
  CollectionStore._(String userId) : super._(userId);
  factory CollectionStore.of(FirebaseUser user) => CollectionStore._(user.uid);
  @override
  DatabaseReference get reference =>
      FirebaseDatabase.instance.reference().child(_userId).child(COLLECTIONS);
  @override
  Collection convert(json) => Collection.fromJson(json);
}

class NoteStore extends FirebaseStore<Note> {
  NoteStore._(String userId) : super._(userId);
  factory NoteStore.of(FirebaseUser user) => NoteStore._(user.uid);
  @override
  DatabaseReference get reference =>
      FirebaseDatabase.instance.reference().child(_userId).child(NOTES);
  @override
  Note convert(json) => Note.fromJson(json);
}
