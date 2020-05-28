import 'package:flutter/material.dart';

import 'response.dart';
import '../models/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'refs.dart';
import 'package:uuid/uuid.dart';

mixin Api<T> {
  T addCollection(Collection collection);
  T updateCollection(Collection collection);
  T addNote(Note note);
  T updateNote(Note note);
}

// Local Implementation

class LocalApi with Api<dynamic> {
  final Box collectionBox;
  final Box noteBox;
  final uuid = Uuid();

  LocalApi({@required this.collectionBox, @required this.noteBox});

  @override
  Collection addCollection(Collection collection) {
    final newCollection = collection.copyWith(key: uuid.v1());
    collectionBox.put(newCollection.key, newCollection);
    return newCollection;
  }

  @override
  Note addNote(Note note) {
    final newNote = note.copyWith(key: uuid.v1());
    noteBox.put(newNote.key, newNote);
    return newNote;
  }

  @override
  Collection updateCollection(Collection collection) {
    collectionBox.put(collection.key, collection);
    return collection;
  }

  @override
  Note updateNote(Note note) {
    noteBox.put(note.key, note);
    return note;
  }
}

// Firebase Implementation

class FirebaseApi with Api<Future<Response>> {
  final String userId;

  const FirebaseApi._(this.userId);

  factory FirebaseApi.ofUser(FirebaseUser user) => FirebaseApi._(
        user.uid,
      );

  Future<Response> syncOnline(LocalApi localApi) async {
    localApi.collectionBox.values.forEach((value) async {
      final collection = Collection.fromJson(value);
      if (!collection.synced) {
        final response = await updateCollection(collection);
        if (response.isSuccessful)
          localApi.updateCollection(collection.copyWith(synced: true));
      }
    });
    localApi.noteBox.values.forEach((value) async {
      final note = Note.fromJson(value);
      if (!note.synced) {
        final response = await updateNote(note);
        if (response.isSuccessful)
          localApi.addNote(note.copyWith(synced: true));
      }
    });
  }

  @override
  Future<Response> addCollection(Collection collection) async {
    final newReferenence = FirebaseDatabase.instance
        .reference()
        .child(userId)
        .child(COLLECTIONS)
        .push();
    final newCollection = collection.copyWith(key: newReferenence.key);
    try {
      await newReferenence.set(newCollection.toJson(online: true));
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
      await newReferenence.set(newNote.toJson(online: true));
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
      await oldReferenence.set(collection.toJson(online: true));
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
      await oldReferenence.set(note.toJson(online: true));
      return Response.success(note);
    } catch (e) {
      return Response.failure(e);
    }
  }
}
