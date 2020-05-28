import 'dart:async';

import '../models/models.dart';
import 'package:flutter/material.dart';
import '../style/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<int> _currentIndexController;
  Stream<int> _currentIndexStream;

  @override
  void initState() {
    super.initState();
    _currentIndexController = StreamController<int>();
    _currentIndexStream = _currentIndexController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    super.dispose();
    _currentIndexController.close();
  }

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
      body: Container(
        child: CollectionsGrid(),
      ),
      floatingActionButton: StreamBuilder<int>(
        initialData: 0,
        stream: _currentIndexStream,
        builder: (context, snapshot) => snapshot.data != 3
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/home/addnote', arguments: Note());
                },
                child: Icon(AppIcons.add_note),
                mini: true,
              )
            : null,
      ),
      bottomNavigationBar: StreamBuilder<int>(
        initialData: 0,
        stream: _currentIndexStream,
        builder: (context, snapshot) => SizedBox(
          height: 48,
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: snapshot.data,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Color(0x99ffffff),
            selectedIconTheme: IconThemeData(size: 20),
            unselectedIconTheme: IconThemeData(size: 20),
            selectedLabelStyle:
                TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            onTap: _currentIndexController.add,
            items: [
              BottomNavigationBarItem(
                  title: Text('Collections'), icon: Icon(AppIcons.collections)),
              BottomNavigationBarItem(
                  title: Text('Notes'), icon: Icon(AppIcons.notes)),
              BottomNavigationBarItem(
                  title: Text('Ideas'), icon: Icon(AppIcons.ideas)),
              BottomNavigationBarItem(
                  title: Text('Account'), icon: Icon(AppIcons.account)),
            ],
          ),
        ),
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

class CollectionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
