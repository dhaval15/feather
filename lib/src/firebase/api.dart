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
    final newReferenence = FirebaseDatabase.instance
        .reference()
        .child(userId)
        .child(COLLECTIONS)
        .push();
    final newCollection = collection.copyWith(key: newReferenence.key);
    try {
      await newReferenence.set(newCollection.toJson());
      return Response.success(newCollection);
    } catch (e) {
      return Response.failure(e);
    }
  }

  @override
  Future<Response> addNote(Note note) async {
    final newReferenence =
        FirebaseDatabase.instance.reference().child(userId).child(NOTES).push();
    final newNote = note.copyWith(key: newReferenence.key);
    try {
      await newReferenence.set(newNote.toJson());
      return Response.success(newNote);
    } catch (e) {
      return Response.failure(e);
    }
  }

  @override
  Future<Response> updateCollection(Collection collection) async {
    final oldReferenence = FirebaseDatabase.instance
        .reference()
        .child(userId)
        .child(COLLECTIONS)
        .child(collection.key);
    try {
      await oldReferenence.set(collection.toJson());
      return Response.success(collection);
    } catch (e) {
      return Response.failure(e);
    }
  }

  @override
  Future<Response> updateNote(Note note) async {
    final oldReferenence = FirebaseDatabase.instance
        .reference()
        .child(userId)
        .child(NOTES)
        .child(note.key);
    try {
      await oldReferenence.set(note.toJson());
      return Response.success(note);
    } catch (e) {
      return Response.failure(e);
    }
  }
}
