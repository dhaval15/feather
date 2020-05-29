import 'status.dart';

class Collection {
  String key;
  String title;
  String description;
  int status;

  Collection({
    this.key,
    this.title,
    this.description,
    this.status = OFFLINE,
  });

  void setForDeletion() => this.status = DELETE;

  factory Collection.fromJson(dynamic json) => Collection(
        key: json['k'],
        title: json['t'],
        description: json['d'],
        status: json['s'] ?? SYNCED,
      );

  Map<String, dynamic> toJson() => {
        'k': key,
        't': title,
        'd': description,
        's': status,
      };
}
