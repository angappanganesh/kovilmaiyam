import 'package:flutter/material.dart';
import 'package:kovilmaiyam/utils/constants.dart';

class ProductPoster extends StatelessWidget {
  const ProductPoster({
    Key key,
    @required this.size,
    this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      // the height of this container is 80% of our width
      height: size.width * 0.8,

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(
            image,
            height: size.width * 0.75,
            width: size.width * 0.75,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {

  final String image, title;

  const Body({Key key, this.image, this.title}) : super(key: key);

  /*
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
                  SizedBox(height: kDefaultPadding),
                  Center(
                    //child: Hero(
                      //tag: 'splashimage', // if this matches a product id, then hero animation is triggered.
                      child: ProductPoster(
                        size: size,
                        image: image,
                      ),
                    //),
                  ),
                  //ListOfColors(),
                  SizedBox(height: kDefaultPadding),
                  Align(
                    alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                    child: Text(title, style: Theme.of(context).textTheme.headline6),
                  ),
                  /*
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  */
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            //ChatAndAddToCart(),
          ],
        ),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Image.asset(
        image,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
