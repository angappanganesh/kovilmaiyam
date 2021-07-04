import 'package:flutter/material.dart';

class UnderConstructionScreen extends StatelessWidget {

  UnderConstructionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Coming Soon!',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.replay),
              label: Text('BACK'),
            ),
          ],
        ),
      ),
    );
  }
}