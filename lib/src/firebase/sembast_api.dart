import 'package:feather/src/firebase/response.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sembast/sembast.dart';
import '../models/models.dart';
import '../models/status.dart';
import 'refs.dart';

class SembastApi {
  static const String dbPath = 'feather.db';
  static const String notes = 'notes';
  static const String collections = 'collections';
  final DatabaseFactory dbFactory;
  static const int version = 1;
  Database db;
  final noteStore = stringMapStoreFactory.store(notes);
  final collectionStore = stringMapStoreFactory.store(collections);

  SembastApi(this.dbFactory);

  Future init() async {
    if (db == null)
      db = await dbFactory.openDatabase(dbPath, version: version);
    else
      throw 'database is already open';
  }

  Future dispose() {
    return db.close();
  }

  Future<Response> loadOnce(String userId) async {
    try {
      final snapshot = await _FirebaseApi.data(userId);
      final collections = snapshot.value[COLLECTIONS];
      final notes = snapshot.value(NOTES);
      if (collections != null)
        await insertMultiple(collectionStore, collections);
      if (notes != null) await insertMultiple(noteStore, notes);
      return Response.success(null);
    } catch (e) {
      return Response.failure(e);
    }
  }

  Future syncOnline(String userId) async {
    final collectionRecords = await collectionStore.find(db,
        finder: Finder(filter: Filter.lessThan('s', SYNCED)));
    for (final record in collectionRecords) {
      try {
        if (record.value['s'] == OFFLINE) {
          // SYNCING ONLINE
          await _FirebaseApi.collection(userId, record.key,
              collection: record.value);
          record.value['s'] = SYNCED;
          await update(collectionStore, record.value);
        } else {
          //DELETION
          await _FirebaseApi.collection(userId, record.key);
          await delete(collectionStore, record.value);
        }
      } catch (e) {}
    }
    final noteRecords = await noteStore.find(db,
        finder: Finder(filter: Filter.lessThan('s', SYNCED)));
    for (final record in noteRecords) {
      try {
        if (record.value['s'] == OFFLINE) {
          //SYNCING ONLINE
          await _FirebaseApi.note(userId, record.key, note: record.value);
          record.value['s'] = SYNCED;
          await update(noteStore, record.value);
        } else {
          //DELETION
          await _FirebaseApi.note(userId, record.key);
          await update(noteStore, record.value);
        }
      } catch (e) {}
    }
  }

  Future<Note> insertNote(Note note) async {
    final map = await insert(noteStore, note.toJson());
    return note..key = map['k'];
  }

  Future<Note> updateNote(Note note) {
    return update(noteStore, note.toJson());
  }

  Future deleteNote(Note note) {
    note.setForDeletion();
    return update(noteStore, note.toJson());
  }

  Future<Collection> insertCollection(Collection collection) async {
    final map = await insert(collectionStore, collection.toJson());
    return collection..key = map['k'];
  }

  Future<Collection> updateCollection(Collection collection) {
    return update(collectionStore, collection.toJson());
  }

  Future deleteCollection(Collection collection) {
    collection.setForDeletion();
    return update(collectionStore, collection.toJson());
  }

  Future insertMultiple(StoreRef store, List values) {
    return store.addAll(db, values);
  }

  Future insert(StoreRef store, dynamic value) {
    return db.transaction((txn) async {
      String key = await store.add(txn, value);
      final record = store.record(value);
      return record.update(txn, {'k': key});
    });
  }

  Future update(StoreRef store, dynamic value) {
    final record = store.record(value['k']);
    return record.update(db, value);
  }

  Future delete(StoreRef store, dynamic value) {
    final record = store.record(value['k']);
    return record.delete(db);
  }
}

class _FirebaseApi {
  static Future note(String userId, String key, {dynamic note}) =>
      FirebaseDatabase.instance
          .reference()
          .child(userId)
          .child(NOTES)
          .child(key)
          .set(note);

  static Future collection(String userId, String key, {dynamic collection}) =>
      FirebaseDatabase.instance
          .reference()
          .child(userId)
          .child(COLLECTIONS)
          .child(key)
          .set(collection);

  static Future<DataSnapshot> data(String userId) =>
      FirebaseDatabase.instance.reference().child(userId).once();
}
