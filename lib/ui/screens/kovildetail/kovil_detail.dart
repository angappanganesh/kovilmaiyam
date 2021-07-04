import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/utils/file_util.dart';

import 'body.dart';

class KovilDetailsScreen extends StatelessWidget {
  final Kovil kovil;
  final FileUtil fileUtil;

  const KovilDetailsScreen({Key key, @required this.kovil, @required this.fileUtil}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
        kovil: kovil,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: Text(''),
      /*
      IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          fileUtil.deleteFile();
          Navigator.pop(context);
        },
      ),
      */
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () {
              fileUtil.deleteFile();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
            label: Text(
            'Logout',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
