import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:kovilmaiyam/models/choices.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_single/single_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_multi/multi_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_tile/tile_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_option/option_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_modal/modal_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_choices/choices_main.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_brightness.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_color.dart';
// import 'features_theme.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:kovilmaiyam/ui/form/smart_select/choices.dart' as choices;
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/utils/file_util.dart';
import 'package:smart_select/smart_select.dart';
import 'package:kovilmaiyam/ui/screens/kovildetail/kovil_detail.dart';

// Network DB
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:kovilmaiyam/repository/data_repository.dart';


class LoginForm extends StatefulWidget 
{
  final FileUtil fileUtil;
  
  const LoginForm({Key key, @required FileUtil this.fileUtil}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> 
{
  int _persistedKovilId;

  String _kovilDistrict = null;
  String _zone = null;
  String _ward = null;
  String _kovilId = null;
  final _passwordController = TextEditingController();
  bool _passwordError = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.fileUtil.readKovilId().then((int value) {
      setState(() {
        _persistedKovilId = value;
      });
    });
  }

  Future<KovilContainer> getKovilData() async {
    await Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("kovil")
        .get();
    List<Kovil> kovilsFromDB = new List<Kovil>();
    snapshot.docs.forEach((DocumentSnapshot document){
      kovilsFromDB.add(Kovil.fromSnapshot(document));
    });

    KovilContainer kovilContainer = new KovilContainer(kovilsFromDB);
    return kovilContainer;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getKovilData(),
      builder: (BuildContext context, AsyncSnapshot<KovilContainer> kovilContainer) {
        if (kovilContainer.hasError) {
          return Text('Something went wrong. Could not retrieve Kovils!');
        }

        if(kovilContainer.data == null) {
          return Container(
            color: kBackgroundColor,
            child: Center(
                child: Container(
                  color: kBackgroundColor,
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      //backgroundColor: kBackgroundColor,
                    ),
                    height: 50.0,
                    width: 50.0,
                  ),
                )
            ),
          );
        }

        //if (snapshot.connectionState == ConnectionState.waiting) {
          //return Text("Loading Kovil Information");
          //return null;
        //}

        //if (snapshot.connectionState == ConnectionState.done) {

          // Directly move to Maiyam List screen if kovil Id is available
          if(_persistedKovilId != null && _persistedKovilId > 0) {
            Kovil persistedKovil = kovilContainer.data.getKovilWithId(_persistedKovilId);
            if(persistedKovil == null) {
              widget.fileUtil.deleteFile();
            }
            else {
              return KovilDetailsScreen(kovil: persistedKovil, fileUtil: widget.fileUtil,);
            }
          }

          return //DefaultTabController(
            //length: 6,
            /*child:*/ Scaffold(
            appBar: AppBar(
              title: Text('Select Kovil'),
            ),
            /*
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.send),
              label: Text('SUBMIT'),
            ),
          ],
        ),
        */
            body: Scrollbar(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20,),
                  /*
              SizedBox(
                height: 100.0,
                child: Hero (
                  tag: 'avnsm',
                  child: Image.asset(
                    'assets/images/avnsm.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              */
                  KeepAliveWidget(
                    child: FeaturesSingleSheet(context, kovilContainer.data),
                    /*
                StickyHeader(
                  header: const FeaturesHeader('Select Kovil for Reporting'),
                  content: FeaturesSingleSheet(),
                ),
                */
                  ),
                ],
              ),
            ),
          );
        //}

        //return CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passwordController.dispose();
    super.dispose();
  }

  Widget FeaturesSingleSheet(BuildContext context, KovilContainer kovilContainer) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(10.0),
            child: Text('Select Kovil for Reporting'),),
          ],
        ),
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Kovil District',
          value: _kovilDistrict,
          choiceItems: kovilContainer.getDistricts(),
          onChange: (state) {
            setState(() => _kovilDistrict = state.value);
            // nullify zone
            _zone = null;
            _passwordController.text = '';
            _passwordError = false;
          },
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/temple.png'),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        getZoneWidget(kovilContainer),
        const Divider(indent: 20),
        getWardWidget(kovilContainer),
        const Divider(indent: 20),
        getKovilWidget(kovilContainer),
        const Divider(indent: 20),
        getPasswordWidget(kovilContainer),
        const SizedBox(height: 100),
        Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //SizedBox(height: 12),
            FloatingActionButton.extended(
              backgroundColor: AllValuesChosen() ? kPrimaryColor : Colors.grey,
              heroTag: null,
              onPressed: () {
                LoginAction(kovilContainer);
              },
              icon: Icon(Icons.send),
              label: Text('LOGIN'),
            ),
          ],
        ),
      ],
    );
  }

  void LoginAction(KovilContainer kovilContainer)
  {
    if (AllValuesChosen()) {
      //Navigator.pop(context);
      Kovil chosenKovil = kovilContainer.getKovilWithId(int.parse(_kovilId));
      if(_passwordController.text.compareTo(chosenKovil.password) == 0) {
        widget.fileUtil.writeKovilId(int.parse(_kovilId));
        setState(() => _passwordError = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KovilDetailsScreen(
              kovil: chosenKovil,
              fileUtil: widget.fileUtil,
            ),
          ),
        );
      }
      else {
        /*
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Incorrect password!")));
                    */
        setState(() => _passwordError = true);
      }
    }
  }

  bool AllValuesChosen()
  {
    return (_kovilDistrict != null && _zone != null && _ward != null && _kovilId != null);
  }

  Widget getZoneWidget(KovilContainer kovilContainer)
  {
    if(_kovilDistrict != null) {
      return SmartSelect<String>.single(
        title: 'Zone',
        value: _zone,
        choiceItems: kovilContainer.getZones(_kovilDistrict),
        onChange: (state) {
          setState(() => _zone = state.value);
          _ward = null;
          _passwordController.text = '';
          _passwordError = false;
        },
        modalType: S2ModalType.bottomSheet,
        modalFilter: true,
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            isTwoLine: true,
            leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/mano.png'),
            ),
          );
        },
      );
    }
    return Container();
  }

  Widget getWardWidget(KovilContainer kovilContainer)
  {
    if(_kovilDistrict != null && _zone != null) {
      return SmartSelect<String>.single(
        title: 'Ward',
        value: _ward,
        choiceItems: kovilContainer.getWards(_kovilDistrict, _zone),
        onChange: (state) {
          setState(() => _ward = state.value);
          _kovilId = null;
          _passwordController.text = '';
          _passwordError = false;
        },
        modalType: S2ModalType.bottomSheet,
        modalFilter: true,
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            isTwoLine: true,
            leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/prabhanjam.png'),
            ),
          );
        },
      );
    }
    return Container();
  }

  Widget getKovilWidget(KovilContainer kovilContainer)
  {
    if(_kovilDistrict != null && _zone != null && _ward != null) {
      return SmartSelect<String>.single(
        title: 'Kovil',
        value: _kovilId,
        choiceItems: kovilContainer.getKovils(_kovilDistrict, _zone, _ward),
        onChange: (state) => setState(() {
          _kovilId = state.value;
          _passwordController.text = '';
          _passwordError = false;
        }),
        modalType: S2ModalType.bottomSheet,
        modalFilter: true,
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            isTwoLine: true,
            leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/shakti.png'),
            ),
          );
        },
      );
    }
    return Container();
  }

  Widget getPasswordWidget(KovilContainer kovilContainer)
  {
    if(_kovilDistrict != null && _zone != null && _ward != null && _kovilId != null) {
      return Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: TextField(
          //keyboardType: TextInputType.visiblePassword,
          controller: _passwordController,
          obscureText: _obscureText,
          enableSuggestions: false,
          autocorrect: false,
          textInputAction: TextInputAction.send,
          onSubmitted: (value) => LoginAction(kovilContainer),
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)
            ),
            //hintText: '',
            labelText: 'Password',
            errorText: _passwordError ? 'Incorrect Password' : null,
            //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
            //prefixText: ' ',
            //suffixText: '#',
            suffixIcon: FlatButton(child: new Icon(Icons.remove_red_eye),
              onPressed: (){
                setState(() => _obscureText = !_obscureText);
              },),
            suffixStyle: const TextStyle(color: Colors.green),
          ),
        ),
      );
    }
    return Container();
  }
}

class AfterSplash1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Kovil Maiyam"),
          automaticallyImplyLeading: false
      ),
      body: new Center(
        /*
                child: new Text("Done!",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0
                    ),),
                 */
        child: SizedBox(
          height: 220.0,
          child: Hero (
            tag: 'avnsm',
            child: Image.asset(
              'assets/images/avnsm.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

      ),
    );
  }
}