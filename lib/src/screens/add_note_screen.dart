import 'package:flutter/material.dart';
import '../models/models.dart';
import '../style/icons.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note note;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    if (note == null) {
      note = ModalRoute.of(context).settings.arguments;
      controller = TextEditingController(text: note.content);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: Theme.of(context).appBarTheme.textTheme.headline6,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(AppIcons.right),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: TextField(
          maxLines: 100,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
