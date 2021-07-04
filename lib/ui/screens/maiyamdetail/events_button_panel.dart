import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovilmaiyam/models/maiyam.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/utils/constants.dart';

import 'package:kovilmaiyam/ui/screens/maiyamevent/dhanvantari/new_event.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/mano/new_event.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/prabhanja/new_event.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/shakti/new_event.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/saraswati/new_event.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/saraswati/all_events.dart';
import 'package:kovilmaiyam/utils/under_construction.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class EventsButtonPanel extends StatelessWidget {
  final Maiyam maiyam;
  final Kovil kovil;

  const EventsButtonPanel({
    Key key, @required this.maiyam, this.kovil
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
          FlatButton.icon(
            onPressed: () {
              if(maiyam.id == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaraswathiAllEvents(
                      kovil: kovil,
                    ),
                  ),
                );
              }
              else {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnderConstructionScreen(),
                  ),
                );
                */
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
              }
            },
            icon: Icon(
              Icons.list,
              color: kBackgroundColor,
              //size: 18.0,
            ),
            label: Text(
              "View All Events",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // it will cover all available spaces
          Spacer(),
          FlatButton.icon(
            onPressed: () {
              if(maiyam.id == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DhanvantariNewEvent(
                      maiyam: maiyam,
                    ),
                  ),
                );
              }
              else if(maiyam.id == 5) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManoNewEvent(
                      maiyam: maiyam,
                    ),
                  ),
                );
              }
              else if(maiyam.id == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrabanjaNewEvent(
                      maiyam: maiyam,
                    ),
                  ),
                );
              }
              else if(maiyam.id == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShakthiNewEvent(
                      maiyam: maiyam,
                    ),
                  ),
                );
              }
              else if(maiyam.id == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaraswathiNewEvent(
                      kovil: kovil,
                    ),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.add_to_photos,
              color: kBackgroundColor,
              //size: 18.0,
            ),
            label: Text(
              "Add Event",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
