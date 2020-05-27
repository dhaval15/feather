import 'package:flutter/material.dart';

class FeatherDialog extends StatefulWidget {
  final String title;
  final bool running;
  final List<Widget> actions;
  final Function() task;

  const FeatherDialog(
      {Key key,
      @required this.title,
      @required this.running,
      this.actions = const [],
      this.task})
      : super(key: key);

  @override
  _FeatherDialogState createState() => _FeatherDialogState();
}

class _FeatherDialogState extends State<FeatherDialog> {
  @override
  void initState() {
    super.initState();
    widget.task?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        widget.running ? CircularProgressIndicator() : SizedBox(),
        ...widget.actions,
      ]),
    );
  }
}
