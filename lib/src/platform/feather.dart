import 'package:flutter/services.dart';

class Feather {
  static final Feather instance = Feather._();
  static const MethodChannel channel =
      MethodChannel('plugins.broken-glass.com/feather');

  Feather._() {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  void Function(String data) _listener;

  void onIntent(void Function(String) listener) {
    this._listener = listener;
  }

  Future _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onIntentData":
        _listener?.call(call.arguments);
    }
  }
}
