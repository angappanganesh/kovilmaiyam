import 'package:flutter/material.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/models/maiyam.dart';
import 'package:kovilmaiyam/ui/screens/maiyamdetail/maiyam_detail.dart';

import 'maiyam_card.dart';

class Body extends StatelessWidget {
  final Kovil kovil;

  Body(@required this.kovil);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          //SearchBox(onChanged: (value) {}),
          //CategoryList(),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  // here we use our demo procuts list
                  itemCount: maiyams.length,
                  itemBuilder: (context, index) => MaiyamCard(
                    itemIndex: index,
                    maiyam: maiyams[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MaiyamDetail(
                            maiyam: maiyams[index],
                            kovil: kovil,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
