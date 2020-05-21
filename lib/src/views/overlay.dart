import 'dart:async';
import 'package:feather/src/firebase/response.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Alignment alignment;
  final BoxDecoration decoration;
  final Color color;
  final Function onTapOutSide;

  const OverlayWidget({
    Key key,
    this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.alignment = Alignment.center,
    this.color,
    this.decoration,
    this.onTapOutSide,
  }) : super(key: key);

  static _OverlayWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<_OverlayWidgetState>();

  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  StreamController<WidgetBuilder> _widgetController;

  void show(WidgetBuilder builder) {
    _widgetController.add(builder);
  }

  void showAsync(WidgetBuilder builder) async {}

  void dismiss() {
    _widgetController.add(null);
  }

  @override
  void initState() {
    super.initState();
    _widgetController = StreamController();
  }

  @override
  void dispose() {
    super.dispose();
    _widgetController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        GestureDetector(
          onTap: widget.onTapOutSide,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: widget.color,
            decoration: widget.decoration,
            child: GestureDetector(
              onTap: () {},
              child: Align(
                alignment: widget.alignment,
                child: StreamBuilder<WidgetBuilder>(
                  initialData: null,
                  stream: _widgetController.stream,
                  builder: (context, snapshot) =>
                      snapshot.data?.call(context) ??
                      SizedBox(width: 0, height: 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
