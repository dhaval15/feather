import 'package:feather/src/firebase/response.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  const TaskDialog({Key key, @required this.task}) : super(key: key);
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  dynamic result;

  @override
  void initState() {
    super.initState();
    if (!widget.task.startConsent) execute();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  void execute() async {
    setState(() {
      widget.task.state = TaskState.running;
    });
    final response = await widget.task.task();
    if (response.isSuccessful) {
      if (widget.task.startConsent) {
        setState(() {
          result = response.result;
          widget.task.state = TaskState.success;
        });
      } else {
        Navigator.of(context).pop(response.result);
      }
    } else {
      setState(() {
        widget.task.state = TaskState.failure;
      });
    }
  }

  List<Widget> get actions {
    switch (widget.task.state) {
      case TaskState.start:
        return [
          FlatButton(
            child: Text(widget.task.cancelAction),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(widget.task.startAction),
            onPressed: execute,
          ),
        ];
        break;
      case TaskState.running:
        return widget.task.cancelable
            ? [
                FlatButton(
                  child: Text(widget.task.cancelAction),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]
            : [];
        break;
      case TaskState.success:
        return [
          FlatButton(
            child: Text(widget.task.successAction),
            onPressed: () {
              Navigator.of(context).pop(result);
            },
          ),
        ];
        break;
      case TaskState.failure:
        return [
          FlatButton(
            child: Text(widget.task.cancelAction),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(widget.task.retryAction),
            onPressed: execute,
          ),
        ];
        break;
    }
    return [];
  }

  String get title {
    switch (widget.task.state) {
      case TaskState.start:
        return widget.task.startLabel;
        break;
      case TaskState.running:
        return widget.task.runningLabel;
        break;
      case TaskState.success:
        return widget.task.successLabel;
        break;
      case TaskState.failure:
        return widget.task.failureLabel;
        break;
    }
    return 'State Undefined';
  }
}

class Task {
  final String startLabel, runningLabel, successLabel, failureLabel;
  final String startAction, cancelAction, retryAction, successAction;
  final bool cancelable, startConsent, successConsent;
  Future<Response> Function() task;
  TaskState state;

  Task({
    this.startConsent = true,
    this.successConsent = true,
    this.successAction = 'Ok',
    this.startAction,
    this.cancelAction = 'Cancel',
    this.retryAction = 'Retry',
    this.cancelable = true,
    this.startLabel,
    this.runningLabel,
    @required this.successLabel,
    @required this.failureLabel,
    this.state = TaskState.start,
    @required this.task,
  });
}

enum TaskState {
  start,
  running,
  success,
  failure,
}
