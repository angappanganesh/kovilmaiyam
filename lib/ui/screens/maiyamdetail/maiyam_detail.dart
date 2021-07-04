import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/maiyam.dart';
import 'package:kovilmaiyam/models/kovil.dart';

import 'body.dart';

class MaiyamDetail extends StatelessWidget {
  final Maiyam maiyam;
  final Kovil kovil;

  const MaiyamDetail({Key key, this.maiyam, this.kovil}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
        maiyam: maiyam,
        kovil: kovil,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      /*
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/cart_with_item.svg'),
          onPressed: () {},
        ),
      ],
      */
    );
  }
}
