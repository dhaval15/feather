class Response<T> {
  final T result;
  final Exception exception;
  final bool isSuccessful;

  Response._({this.result, this.exception}) : isSuccessful = exception == null;

  factory Response.success(T result) => Response._(result: result);
  factory Response.failure(Exception exception) =>
      Response._(exception: exception);

  @override
  String toString() => {
        'isSuccessful': isSuccessful,
        'result': result,
        'exception': exception,
      }.toString();
}
