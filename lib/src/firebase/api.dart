import 'response.dart';
import '../models/models.dart';

mixin Api {
  Future<Response> addCollection(Collection collection);
  Future<Response> updateCollection(Collection collection);
  Future<Response> addNote(Note note);
  Future<Response> updateNote(Note note);
}

// Default Implementation

class FirebaseApi with Api {
  @override
  Future<Response> addCollection(Collection collection) {
    // TODO: implement addCollection
    throw UnimplementedError();
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
