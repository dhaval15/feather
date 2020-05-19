abstract class Response<T> {
  final T _data;

  Response(this._data);

  factory Response.success(T data) => Success._(data);
  factory Response.failure(T error) => Failure._(error);
}

class Success<T> extends Response<T> {
  Success._(T data) : super(data);
  T get data => _data;
}

class Failure<T extends Error> extends Response<T> {
  Failure._(T data) : super(data);
  T get error => _data;
}
