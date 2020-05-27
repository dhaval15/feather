import '../utils/screen_utils.dart';
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

class _FeatherDialogState extends State<FeatherDialog>
    with ScreenUtilStateMixin {
  @override
  void initState() {
    super.initState();
    widget.task?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          vGap(16),
          widget.running ? CircularProgressIndicator() : SizedBox(),
          vGap(16),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions,
          )
        ],
      ),
    );
  }
}
