class Collection {
  final String key;
  final String title;
  final String description;

  Collection({this.key, this.title, this.description});

  factory Collection.fromJson(dynamic json) => Collection(
        key: json['k'],
        title: json['t'],
        description: json['d'],
      );

  Collection copyWith({String key, String title, String description}) =>
      Collection(
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() => {
        'k': key,
        't': title,
        'd': description,
      };
}
