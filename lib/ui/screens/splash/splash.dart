import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'splash_body.dart';

class SplashScreen extends StatefulWidget {
  /// Seconds to navigate after for time based navigation
  final int seconds;

  /// App title, shown in the middle of screen in case of no image available
  final Text title;

  /// Page background color
  final Color backgroundColor;

  /// Style for the laodertext
  final TextStyle styleTextUnderTheLoader;

  /// The page where you want to navigate if you have chosen time based navigation
  final dynamic navigateAfterSeconds;

  /// Main image size
  final double photoSize;

  /// Triggered if the user clicks the screen
  final dynamic onClick;

  /// Loader color
  final Color loaderColor;

  /// Main image mainly used for logos and like that
  final Image image;
  final String assetImage;

  /// Loading text, default: "Loading"
  final Text loadingText;

  ///  Background image for the entire screen
  final ImageProvider imageBackground;

  /// Background gradient for the entire screen
  final Gradient gradientBackground;

  /// Whether to display a loader or not
  final bool useLoader;

  /// Custom page route if you have a custom transition you want to play
  final Route pageRoute;

  /// RouteSettings name for pushing a route with custom name (if left out in MaterialApp route names) to navigator stack (Contribution by Ramis Mustafa)
  final String routeName;

  /// expects a function that returns a future, when this future is returned it will navigate
  final Future<dynamic> navigateAfterFuture;

  final bool useAppBar;

  /// Use one of the provided factory constructors instead of.
  @protected
  SplashScreen({
    this.loaderColor,
    this.navigateAfterFuture,
    this.seconds,
    this.photoSize,
    this.pageRoute,
    this.onClick,
    this.navigateAfterSeconds,
    this.title = const Text(''),
    this.backgroundColor = Colors.white,
    this.styleTextUnderTheLoader =
    const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    this.image,
    this.assetImage,
    this.loadingText = const Text(""),
    this.imageBackground,
    this.gradientBackground,
    this.useLoader = true,
    this.routeName,
    this.useAppBar,
  });

  factory SplashScreen.timer(
      {@required int seconds,
        Color loaderColor,
        Color backgroundColor,
        double photoSize,
        Text loadingText,
        Image image,
        String assetImage,
        Route pageRoute,
        dynamic onClick,
        dynamic navigateAfterSeconds,
        Text title,
        TextStyle styleTextUnderTheLoader,
        ImageProvider imageBackground,
        Gradient gradientBackground,
        bool useLoader,
        String routeName,
        bool useAppBar}) =>
      SplashScreen(
        loaderColor: loaderColor,
        seconds: seconds,
        photoSize: photoSize,
        loadingText: loadingText,
        backgroundColor: backgroundColor,
        image: image,
        assetImage: assetImage,
        pageRoute: pageRoute,
        onClick: onClick,
        navigateAfterSeconds: navigateAfterSeconds,
        title: title,
        styleTextUnderTheLoader: styleTextUnderTheLoader,
        imageBackground: imageBackground,
        gradientBackground: gradientBackground,
        useLoader: useLoader,
        routeName: routeName,
        useAppBar: useAppBar,
      );

  factory SplashScreen.network(
      {@required Future<dynamic> navigateAfterFuture,
        Color loaderColor,
        Color backgroundColor,
        double photoSize,
        Text loadingText,
        Image image,
        String assetImage,
        Route pageRoute,
        dynamic onClick,
        dynamic navigateAfterSeconds,
        Text title,
        TextStyle styleTextUnderTheLoader,
        ImageProvider imageBackground,
        Gradient gradientBackground,
        bool useLoader,
        String routeName,
        bool useAppBar}) =>
      SplashScreen(
        loaderColor: loaderColor,
        navigateAfterFuture: navigateAfterFuture,
        photoSize: photoSize,
        loadingText: loadingText,
        backgroundColor: backgroundColor,
        image: image,
        assetImage: assetImage,
        pageRoute: pageRoute,
        onClick: onClick,
        navigateAfterSeconds: navigateAfterSeconds,
        title: title,
        styleTextUnderTheLoader: styleTextUnderTheLoader,
        imageBackground: imageBackground,
        gradientBackground: gradientBackground,
        useLoader: useLoader,
        routeName: routeName,
        useAppBar: useAppBar,
      );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.routeName != null && widget.routeName is String && "${widget.routeName[0]}" != "/") {
      throw new ArgumentError("widget.routeName must be a String beginning with forward slash (/)");
    }
    if (widget.navigateAfterFuture == null) {
      Timer(Duration(seconds: widget.seconds), () {
        if (widget.navigateAfterSeconds is String) {
          // It's fairly safe to assume this is using the in-built material
          // named route component
          Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
        } else if (widget.navigateAfterSeconds is Widget) {
          Navigator.of(context).pushReplacement(widget.pageRoute != null
              ? widget.pageRoute
              : new MaterialPageRoute(
              settings:
              widget.routeName != null ? RouteSettings(name: "${widget.routeName}") : null,
              builder: (BuildContext context) => widget.navigateAfterSeconds));
        } else {
          throw new ArgumentError('widget.navigateAfterSeconds must either be a String or Widget');
        }
      });
    } else {
      widget.navigateAfterFuture.then((navigateTo) {
        if (navigateTo is String) {
          // It's fairly safe to assume this is using the in-built material
          // named route component
          Navigator.of(context).pushReplacementNamed(navigateTo);
        } else if (navigateTo is Widget) {
          Navigator.of(context).pushReplacement(widget.pageRoute != null
              ? widget.pageRoute
              : new MaterialPageRoute(
              settings:
              widget.routeName != null ? RouteSettings(name: "${widget.routeName}") : null,
              builder: (BuildContext context) => navigateTo));
        } else {
          throw new ArgumentError('widget.navigateAfterFuture must either be a String or Widget');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: widget.useAppBar ? buildAppBar(context) : null,
      body: Body(
        image: widget.assetImage,
        title: widget.title.data,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading:
      Hero (
        tag: 'avnsm',
        child: Image.asset(
            'assets/images/avnsm.png'
        ),
      ),
      /*
      IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      */
      centerTitle: false,
      title: Text(
        'Kovil Maiyam',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          //fontFamily: 'trocchi',
          color: Colors.amber,
      )
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
