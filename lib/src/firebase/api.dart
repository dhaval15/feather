import 'response.dart';
import '../models/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin Api {
  Future<Response> addCollection(Collection collection);
  Future<Response> updateCollection(Collection collection);
  Future<Response> addNote(Note note);
  Future<Response> updateNote(Note note);
}

// Default Implementation

class FirebaseApi with Api {
  final String userId;

  const FirebaseApi._(this.userId);

  factory FirebaseApi.ofUser(FirebaseUser user) => FirebaseApi._(user.uid);

  static const String NOTES = 'notes', COLLECTIONS = 'collections';
  @override
  Future<Response> addCollection(Collection collection) async {
    final newReferenence =
        FirebaseDatabase.instance.reference().child(userId).push();
    final newCollection = collection.copyWith(key: newReferenence.key);
    try {
      await newReferenence.set(newCollection.toJson());
      return Response.success(newCollection);
    } catch (e) {
      return Response.failure(e);
    }
  }

  @override
  Future<Response> addNote(Note note) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<Response> updateCollection(Collection collection) {
    // TODO: implement updateCollection
    throw UnimplementedError();
  }

  @override
  Future<Response> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
