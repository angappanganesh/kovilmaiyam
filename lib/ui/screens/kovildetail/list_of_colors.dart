import 'package:flutter/material.dart';

import 'package:kovilmaiyam/utils/constants.dart';
import 'color_dots.dart';
import 'package:kovilmaiyam/utils/google_photos_explorer.dart';

class ListOfColors extends StatelessWidget {
  final String photos_url;

  const ListOfColors({
    Key key, this.photos_url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Photo_URL = 000' + photos_url + '000');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotosExplorer(
                    photosUrl: photos_url,
                  ),
                ),
              );
            },
            icon: Icon(Icons.photo_camera, color: Colors.lightGreen,),
            label: Text('Click to see more photos...', style: TextStyle(color: Color(0xFF80989A)),),
          ),
        ],
      ),
    );
  }
}
