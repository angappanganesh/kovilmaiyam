import 'package:flutter/material.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:kovilmaiyam/ui/form/smart_select/choices.dart' as choices;
import 'package:kovilmaiyam/ui/screens/admin/admin_login.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/ui/screens/login/login_form.dart';
import 'package:kovilmaiyam/utils/file_util.dart';
import 'package:kovilmaiyam/utils/under_construction.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class WelcomeHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
              'Kovil Maiyam',
            style: new TextStyle(
              //fontWeight: FontWeight.w500,
              //fontFamily: 'trocchi',
              //color: Colors.amber,
            ),
          ),
          automaticallyImplyLeading: false
      ),
      body: new Column(
        children: <Widget>[
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 260,
              child: Hero (
                tag: 'avnsm',
                child: Image.asset(
                  'assets/images/avnsm.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Welcome to Aram Valartha Naayagi Sevai Maiyam\'s Kovil Maiyam',
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'nunito',
            fontSize: 20,
            color: Colors.orange,
            //height: 5,
          ),
        ),
        SizedBox(height: 20),
        ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginForm(
                    fileUtil: new FileUtil(),
                  ),
                ),
              );
            },
            label: Text('Login for Reporting'),
            icon: Icon(Icons.send, color: Colors.amber),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: kPrimaryColor,
            textColor: kBackgroundColor,
            //shape: ShapeBorder.,
          ),
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton.icon(
            onPressed: () {
             /*
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
              */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminLoginScreen(),
                ),
              );
            },
            label: Text('Admin Login'),
            icon: Icon(Icons.person, color: Colors.amber),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: kPrimaryColor,
            textColor: kBackgroundColor,
            //shape: ShapeBorder.,
          ),
        ),
        SizedBox(height: 20),
      ]
      ),
    );
  }
}