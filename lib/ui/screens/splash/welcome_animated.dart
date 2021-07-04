import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kovilmaiyam/ui/screens/welcome/welcome_home.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeHome(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Padding(padding: EdgeInsets.only(bottom: 30.0),child:new Image.asset('assets/images/avnsm.png',height: 75.0,fit: BoxFit.scaleDown,))


            ],),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*
              new Image.asset(
                'assets/images/portraitcollage6.jpg',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
              */
              Text(
                'Welcome to Aram Valartha Nayaki\nSevai Maiyam\'s\nKovil Maiyam',
                style: TextStyle(
                  fontFamily: 'trocchi',
                  fontWeight: FontWeight.w500,
                  fontSize: animation.value * 15,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}