class Response<T> {
  final T result;
  final Error error;
  final bool isSuccessful;

  Response._({this.result, this.error}) : isSuccessful = result != null;

  factory Response.success(T result) => Response._(result: result);
  factory Response.failure(Error error) => Response._(error: error);
}
