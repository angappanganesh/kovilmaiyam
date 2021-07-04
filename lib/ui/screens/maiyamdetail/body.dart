import 'package:flutter/material.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/maiyam.dart';
import 'package:kovilmaiyam/models/kovil.dart';

import 'events_button_panel.dart';
import 'list_of_colors.dart';
import 'maiyam_image.dart';

class Body extends StatelessWidget {
  final Maiyam maiyam;
  final Kovil kovil;

  const Body({Key key, this.maiyam, this.kovil}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${maiyam.id}',
                      child: MaiyamImagePoster(
                        size: size,
                        image: maiyam.image,
                      ),
                    ),
                  ),
                  ListOfColors(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      maiyam.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    maiyam.quote,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      maiyam.description,
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            EventsButtonPanel(maiyam: maiyam, kovil: kovil,),
          ],
        ),
      ),
    );
  }
}
