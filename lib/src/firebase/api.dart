import 'response.dart';
import '../models/models.dart';

mixin Api {
  Future<Response> addCollection(Collection collection);
  Future<Response> updateCollection(Collection collection);
  Future<Response> addNote(Note note);
  Future<Response> updateNote(Note note);
}

// Default Implementation

class FirebaseApi with Api {}
