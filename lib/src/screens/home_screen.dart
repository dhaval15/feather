import 'package:flutter/material.dart';
import '../style/style.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feather'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(AppIcons.sort),
            onPressed: _sortPopup,
          ),
          IconButton(
            icon: Icon(AppIcons.view),
            onPressed: _viewPopup,
          ),
        ],
      ),
    );
  }

  void _sortPopup() {
    //TODO implement Sorting Facility : Time, ModifiedDate, Name, CreateDate.
  }

  void _viewPopup() {
    //TODO implement View Changing Facility : List or Grid.
  }
}
