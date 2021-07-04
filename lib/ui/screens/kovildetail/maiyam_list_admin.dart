import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovilmaiyam/ui/screens/maiyamlist/maiyam_list.dart';

import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/utils/google_photos_explorer.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/utils/under_construction.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class MaiyamListAdmin extends StatelessWidget {
  final Kovil kovil;

  const MaiyamListAdmin({
    Key key,
    this.kovil
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          /*
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: 18,
          ),
          SizedBox(width: kDefaultPadding / 2),
          Text(
            "Chat",
            style: TextStyle(color: Colors.white),
          ),
          */
          FlatButton.icon(
            onPressed: () {
              Dialogs.bottomMaterialDialog(
                  msg: 'We are keen as well. Feature coming soon.',
                  title: 'Work in progress!',
                  titleStyle: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w900,
                    color: kSecondaryColor,
                  ),
                  animation: 'assets/lottie/construction.json',
                  color: Colors.white,
                  context: context,
                  actions: [
                    /*
                        IconsOutlineButton(
                          onPressed: () {},
                          text: 'Cancel',
                          iconData: Icons.cancel_outlined,
                          textStyle: TextStyle(color: Colors.grey),
                          iconColor: Colors.grey,
                        ),
                        */
                    IconsButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Got it',
                      color: kPrimaryColor,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                  ]);
            },
            icon: SvgPicture.asset(
              "assets/icons/chat.svg",
              height: 18,
            ),
            label: Text(
              "Kovil Admin",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // it will cover all available spaces
          Spacer(),
          FlatButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaiyamList(kovil: kovil)
                ),
              );
            },
            icon: Image.asset(
              "assets/icons/temple4.png",
              height: 18,
            ),
            label: Text(
              "Kovil Maiyam",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
