import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';

import 'body.dart';
import 'package:flutter/services.dart';

class MaiyamList extends StatelessWidget {
  final Kovil kovil;
  //final Persist storage;

  MaiyamList({Key key, @required this.kovil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: kPrimaryColor,
      body: Body(kovil),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      //toolbarHeight: 80,
      centerTitle: false,
      title: Text(kovil.name),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
