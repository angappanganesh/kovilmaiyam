import 'package:flutter/material.dart';
import 'package:kovilmaiyam/ui/screens/admin/admin_file.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen>
{
  final Color primaryColor = kSecondaryColor;
  final Color backgroundColor = kBackgroundColor;
  final AssetImage backgroundImage = AssetImage('assets/images/bloom.png');
  bool _obscureText = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Scrollbar(
        child: ListView(
        children: <Widget>[
          new ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: this.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Kovil Maiyam",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                  Text(
                    "Admin Login",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "Username",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "Password",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter password',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: FlatButton(child: new Icon(Icons.remove_red_eye),
                        onPressed: (){
                          setState(() => _obscureText = !_obscureText);
                        },),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: this.primaryColor,
                    color: this.primaryColor,
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        new Expanded(
                          child: Container(),
                        ),
                        new Transform.translate(
                          offset: Offset(15.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                color: this.primaryColor,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      if(_usernameController.text.toLowerCase().compareTo('admin') == 0 &&
                        _passwordController.text.compareTo('vanam@2018') == 0) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminSaveFile(),
                          ),
                        );
                        // Login succeeded
                        /*
                        Dialogs.bottomMaterialDialog(
                          msg: 'Login Successful!',
                          animation: 'assets/lottie/congrats.json',
                          title: 'Success!',
                          titleStyle: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w900,
                            color: kSecondaryColor,
                          ),
                          color: Colors.white,
                          context: context,
                          actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminSaveFile(),
                                ),
                              );
                            },
                            text: 'OK',
                            iconData: Icons.done,
                            color: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ])
                        */
                      }
                      else {
                          Dialogs.bottomMaterialDialog(
                            msg: 'Incorrect username or password.',
                            title: 'Login unsuccessful!',
                            animation: 'assets/lottie/failure1.json',
                            titleStyle: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w900,
                              color: kSecondaryColor,
                            ),
                            barrierDismissible: false,
                            color: Colors.white,
                            context: context,
                            actions: [
                            IconsButton(
                              onPressed: () {
                                Navigator.pop(context);
                                /*
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SaraswathiNewEvent(kovil: widget.kovil),
                                  ),
                                );
                                */
                              },
                              text: 'Retry',
                              iconData: Icons.error,
                              color: Colors.red,
                              textStyle: TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}