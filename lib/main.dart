import 'package:flutter/material.dart';
import 'package:kovilmaiyam/ui/screens/splash/splash.dart';
//import 'package:kovilmaiyam/ui/screens/login/login_form.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/ui/screens/welcome/welcome_home.dart';
import 'package:kovilmaiyam/ui/screens/splash/welcome_animated.dart';
import 'package:kovilmaiyam/models/choices.dart';

void main() {
    runApp(new MaterialApp(
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.teal,
            fontFamily: 'OpenSans'
            //fontFamily: 'trocchi'
        ),
        home: new MyApp(),
    ));
}


class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
        return new SplashScreen(
            seconds: 5,
            navigateAfterSeconds: SplashScreen2(),
            title: new Text('Saraswathi Maiyam',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
            image: new Image.asset('assets/images/saraswati.png'),
            assetImage: 'assets/images/frontscreened/natraj4.jpg',
            backgroundColor: Colors.white,
            //imageBackground: AssetImage("assets/images/saraswati.png"),
            //styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            //onClick: ()=>print("Flutter Egypt"),
            useLoader: false,
            useAppBar: false,
        );
    }

    Widget SplashScreen2()
    {
        return new SplashScreen(
            seconds: 3,
            navigateAfterSeconds: WelcomeHome(),
            title: new Text('Mano Maiyam',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
            image: new Image.asset('assets/images/mano.png'),
            assetImage: 'assets/images/portraitcollage6.jpg',
            backgroundColor: Colors.white,
            //imageBackground: AssetImage("assets/images/mano.png"),
            //styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            //onClick: ()=>print("Flutter Egypt"),
            useLoader: false,
            useAppBar: true,
        );
    }

    Widget SplashScreen3()
    {
        return new SplashScreen(
            seconds: 1,
            navigateAfterSeconds: SplashScreen4(),
            title: new Text('Dhanvantari Maiyam',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
            image: new Image.asset('assets/images/dhanvantari.png'),
            assetImage: 'assets/images/frontscreened/natraj3.png',
            backgroundColor: Colors.white,
            //imageBackground: AssetImage("assets/images/dhanvantari.png"),
            //styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            //onClick: ()=>print("Flutter Egypt"),
            useLoader: false,
        );
    }

    Widget SplashScreen4()
    {
        return new SplashScreen(
            seconds: 1,
            navigateAfterSeconds: SplashScreen5(),
            title: new Text('Prabhanja Maiyam',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
            image: new Image.asset('assets/images/prabhanjam.png'),
            assetImage: 'assets/images/portraitcollage3.jpg',
            backgroundColor: Colors.white,
            //imageBackground: AssetImage("assets/images/prabhanjam.png"),
            //styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            //onClick: ()=>print("Flutter Egypt"),
            useLoader: false,
        );
    }

    Widget SplashScreen5()
    {
        return new SplashScreen(
            seconds: 1,
            navigateAfterSeconds: new WelcomeHome(),
            title: new Text('Shakti Maiyam',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
            image: new Image.asset('assets/images/shakti.png'),
            assetImage: 'assets/images/frontscreened/natraj3.png',
            backgroundColor: Colors.white,
            //imageBackground: AssetImage("assets/images/shakti.png"),
            //styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            //onClick: ()=>print("Flutter Egypt"),
            useLoader: false,
        );
    }
}