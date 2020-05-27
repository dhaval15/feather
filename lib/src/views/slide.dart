import 'dart:async';

import 'package:flutter/material.dart';

class Slide extends StatefulWidget {
  final WidgetBuilder builder;

  const Slide({Key key, this.builder}) : super(key: key);

  static _SlideState of(BuildContext context) =>
      context.findAncestorStateOfType<_SlideState>();

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  StreamController<WidgetBuilder> _controller;

  void add({WidgetBuilder builder}) {
    _controller.add(builder);
  }

  @override
  void initState() {
    super.initState();
    _controller = StreamController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WidgetBuilder>(
        initialData: widget.builder,
        stream: _controller.stream,
        builder: (context, snapshot) => snapshot.data(context));
  }
}
