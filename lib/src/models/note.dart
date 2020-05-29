import 'status.dart';

class Note {
  String key;
  String title;
  String content;
  String collectionId;
  int status;

  Note({
    this.key,
    this.title,
    this.content,
    this.collectionId,
    this.status = OFFLINE,
  });

  void setForDeletion() => this.status = DELETE;

  factory Note.fromJson(dynamic json) => Note(
        key: json['k'],
        title: json['t'],
        content: json['c'],
        collectionId: json['i'],
        status: json['s'] ?? SYNCED,
      );

  Map<String, dynamic> toJson() => {
        'k': key,
        't': title,
        'c': content,
        'i': collectionId,
        's': status,
      };
}
