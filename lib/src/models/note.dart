class Note {
  final String key;
  final String title;
  final String content;
  final String collectionId;
  final bool synced;

  Note({
    this.key,
    this.title,
    this.content,
    this.collectionId,
    this.synced = false,
  });

  factory Note.fromJson(dynamic json) => Note(
        key: json['k'],
        title: json['t'],
        content: json['c'],
        collectionId: json['i'],
        synced: json['s'],
      );

  Note copyWith({
    String key,
    String title,
    String content,
    String collectionId,
    bool synced,
  }) =>
      Note(
        key: key ?? this.key,
        title: title ?? this.title,
        content: content ?? this.content,
        collectionId: collectionId ?? this.collectionId,
        synced: synced ?? this.synced,
      );

  Map<String, dynamic> toJson({bool online = false}) => {
        'k': key,
        't': title,
        'c': content,
        'i': collectionId,
        's': !online ? synced : null,
      };
}
