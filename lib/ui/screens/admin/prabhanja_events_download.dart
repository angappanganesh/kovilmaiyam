import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:kovilmaiyam/models/saraswathi_event.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:ext_storage/ext_storage.dart';
import 'dart:io';
import 'package:kovilmaiyam/utils/constants.dart';
import 'dart:convert';
import 'package:kovilmaiyam/utils/file_util.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class PrabhanjaEventsDownload extends StatefulWidget {

  @override
  _PrabhanjaEventsDownloadState createState() =>
      _PrabhanjaEventsDownloadState();

}

class _PrabhanjaEventsDownloadState extends State<PrabhanjaEventsDownload>
{
  String eventFileName = '';
  String eventFileContents = '';
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  void initState() {
    AdminFileUtil.getPermission();
    super.initState();
  }

  Future<void> waitFor() {
    return Future.delayed(Duration(seconds: 1));
  }

  /*
  Future<String> getEventsData() async {
    String SaraswathiEventListDataAsCsv = SaraswathiEvent.getCsvTitle() + '\n';
    await Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("saraswathi_event")
        .get();
    List<SaraswathiEvent> studentsFromDB = new List<SaraswathiEvent>();
    snapshot.docs.forEach((DocumentSnapshot document) {
      SaraswathiEvent event = SaraswathiEvent.fromSnapshot(document);
      SaraswathiEventListDataAsCsv += event.toCsvString() + '\n';
    });
    return SaraswathiEventListDataAsCsv;
  }
  */

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        setState(() {
          stateTextWithIcon = stateTextWithIcon;
        });
        waitFor().then((value) {
          stateTextWithIcon = ButtonState.fail;
          setState(() {
            stateTextWithIcon = stateTextWithIcon;
          });
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
                IconsButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Got it',
                  color: kPrimaryColor,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ]);
        });
        /*
        String path =
        await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
        String fileName = dateAsFileName(DateTime.now()) + '_' + 'Saraswathi_Events.csv';
        String fullPath = path + fileName;
        getEventsData().then((String csvContents) {
          AdminFileUtil.saveFile(fullPath, csvContents).then((value) {
            waitFor().then((value) {
              stateTextWithIcon = ButtonState.success;
              setState(() {
                stateTextWithIcon = stateTextWithIcon;
                eventFileContents = csvContents;
                eventFileName = fileName;
              });
            });
          });
        });
        */
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
      //await Share.file(eventFileName, eventFileName, utf8.encode(eventFileContents), 'text/csv');
        break;
      case ButtonState.fail:
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
              IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Got it',
                color: kPrimaryColor,
                textStyle: TextStyle(color: Colors.white),
              ),
            ]);
      //stateTextWithIcon = ButtonState.idle;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressButton.icon(
        maxWidth: 378.0,
        minWidth: 78.0,
        iconedButtons: {
          ButtonState.idle: IconedButton(
              text: "Prabhanja Maiyam Event List",
              icon: Icon(Icons.file_download, color: Colors.white),
              color: Colors.lightGreen),
          ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.amber),
          ButtonState.fail: IconedButton(
              text: "Failed",
              icon: Icon(Icons.cancel, color: Colors.white),
              color: Colors.red.shade300),
          ButtonState.success: IconedButton(
              text: "Share Prabhanja Maiyam Events file",
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              color: Colors.green.shade400)
        },
        onPressed: onPressedIconWithText,
        state: stateTextWithIcon
    );
  }
}