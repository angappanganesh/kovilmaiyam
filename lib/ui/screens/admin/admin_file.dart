import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/ui/screens/admin/saraswathi_events_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/saraswathi_students_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/sakthi_events_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/dhanvantari_events_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/mano_events_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/prabhanja_events_download.dart';
import 'package:kovilmaiyam/ui/screens/admin/kovil_list_download.dart';
import 'package:kovilmaiyam/utils/constants.dart';

import 'package:material_dialogs/material_dialogs.dart';

class AdminSaveFile extends StatefulWidget {
  AdminSaveFile({Key key}) : super(key: key);

  @override
  _AdminSaveFileState createState() => _AdminSaveFileState();
}

class _AdminSaveFileState extends State<AdminSaveFile> {

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Admin Imports'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //buildCustomButton(),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  KovilListDownload(kovilContainer: kovilContainer.data),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  SaraswathiStudentsDownload(kovilContainer: kovilContainer.data),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  SaraswathiEventsDownload(kovilContainer: kovilContainer.data),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  SakthiEventsDownload(),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  DhanvantariEventsDownload(),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  ManoEventsDownload(),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  PrabhanjaEventsDownload(),
                ],
              ),
            ),
          );
        }
    );
  }

}