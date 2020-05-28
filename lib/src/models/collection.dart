class Collection {
  final String key;
  final String title;
  final String description;
  final bool synced;

  Collection({
    this.key,
    this.title,
    this.description,
    this.synced = false,
  });

  factory Collection.fromJson(dynamic json) => Collection(
        key: json['k'],
        title: json['t'],
        description: json['d'],
        synced: json['s'],
      );

  Collection copyWith(
          {String key, String title, String description, bool synced}) =>
      Collection(
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        synced: synced,
      );

  Map<String, dynamic> toJson({bool online = false}) => {
        'k': key,
        't': title,
        'd': description,
        's': !online ? synced : null,
      };
}
