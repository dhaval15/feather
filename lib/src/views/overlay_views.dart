import 'package:flutter/material.dart';
import 'overlay.dart';
import '../utils/utils.dart';

class LoadingContainer<T> extends StatefulWidget {
  final String title;
  final T Function() task;
  const LoadingContainer({Key key, this.title, this.task}) : super(key: key);

  @override
  _LoadingContainerState<T> createState() => _LoadingContainerState<T>();
}

class _LoadingContainerState<T> extends State<LoadingContainer<T>>
    with ScreenUtilStateMixin {
  @override
  void initState() {
    super.initState();
    _execute();
  }

  void _execute() async {
    T result = widget.task();
    OverlayWidget.of(context).dismiss(result: result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(widget.title, style: Theme.of(context).textTheme.headline4),
        vGap(8),
        CircularProgressIndicator(),
      ],
    );
  }
}
