class Note {
  final String key;
  final String title;
  final String content;
  final String collectionId;

  Note({this.key, this.title, this.content, this.collectionId});

  factory Note.fromJson(dynamic json) => Note(
        key: json['k'],
        title: json['t'],
        content: json['c'],
        collectionId: json['i'],
      );

  Note copyWith({String key, String title, String content}) => Note(
        key: key ?? this.key,
        title: title ?? this.title,
        content: content ?? this.content,
        collectionId: collectionId ?? this.collectionId,
      );

  Map<String, dynamic> toJson() => {
        'k': key,
        't': title,
        'c': content,
        'i': collectionId,
      };
}
