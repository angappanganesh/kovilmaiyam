import 'package:flutter/material.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';

import 'maiyam_list_admin.dart';
import 'list_of_colors.dart';
import 'kovil_image.dart';

class Body extends StatelessWidget {
  final Kovil kovil;

  String TokenizeAddress(String address)
  {
    String tokAddress = '';
    address.split(new RegExp("[ ]*[,]+[ ]*")).forEach((element) {
      tokAddress += element + '\n';
    });
    return tokAddress;
  }

  const Body({Key key, this.kovil}) : super(key: key);
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
                      tag: '23', // if this matches a product id, then hero animation is triggered.
                      child: ProductPoster(
                        size: size,
                        image: 'assets/images/temple.png',
                      ),
                    ),
                  ),
                  ListOfColors(photos_url: kovil.photos_url),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      kovil.name,
                      //'Arulmigu Meenakshi Amman Sametha Sundareshwarar temple',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    kovil.tagline,
                    //'Om Nama Shivaya',
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
                      //kovil.description,
                      TokenizeAddress(kovil.contact.address),
                      //'13/4, Shivan Kovil Street\nNanganallur\nChennai 600045',
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            MaiyamListAdmin(kovil: kovil,),
          ],
        ),
      ),
    );
  }
}
