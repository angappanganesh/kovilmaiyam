import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/models/saraswathi_student.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:ext_storage/ext_storage.dart';
import 'dart:io';
import 'package:kovilmaiyam/utils/constants.dart';
import 'dart:convert';
import 'package:kovilmaiyam/utils/file_util.dart';

class SaraswathiStudentsDownload extends StatefulWidget {
  final KovilContainer kovilContainer;

  SaraswathiStudentsDownload({Key key, @required KovilContainer this.kovilContainer}) : super(key: key);

  @override
  _SaraswathiStudentsDownloadState createState() =>
      _SaraswathiStudentsDownloadState();

}

class _SaraswathiStudentsDownloadState extends State<SaraswathiStudentsDownload>
{
  String studentFileName = '';
  String studentFileContents = '';
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  void initState() {
    AdminFileUtil.getPermission();
    super.initState();
  }

  Future<void> waitFor() {
    return Future.delayed(Duration(seconds: 1));
  }

  Future<String> getStudentsData() async {
    String SaraswathiStudentListDataAsCsv = SaraswathiStudent.getCsvTitleWithKovilDetails() + '\n';
    await Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("saraswathi_student")
        .get();
    List<SaraswathiStudent> studentsFromDB = new List<SaraswathiStudent>();
    snapshot.docs.forEach((DocumentSnapshot document) {
      SaraswathiStudent student = SaraswathiStudent.fromSnapshot(document);
      SaraswathiStudentListDataAsCsv += student.toCsvStringWithKovilDetails(widget.kovilContainer.getKovilWithId(student.kovil_id)) + '\n';
    });
    return SaraswathiStudentListDataAsCsv;
  }

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        setState(() {
          stateTextWithIcon = stateTextWithIcon;
        });
        String path =
        await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
        String fileName = dateAsFileName(DateTime.now()) + '_' + 'Saraswathi_Students.csv';
        String fullPath = path + fileName;
        getStudentsData().then((String csvContents) {
          AdminFileUtil.saveFile(fullPath, csvContents).then((value) {
            waitFor().then((value) {
              stateTextWithIcon = ButtonState.success;
              setState(() {
                stateTextWithIcon = stateTextWithIcon;
                studentFileContents = csvContents;
                studentFileName = fileName;
              });
            });
          });
        });
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        await Share.file(studentFileName, studentFileName, utf8.encode(studentFileContents), 'text/csv');
        //stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
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
              text: "Saraswathi Maiyam Student List",
              icon: Icon(Icons.file_download, color: Colors.white),
              color: Colors.blue),
          ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.amber),
          ButtonState.fail: IconedButton(
              text: "Failed",
              icon: Icon(Icons.cancel, color: Colors.white),
              color: Colors.red.shade300),
          ButtonState.success: IconedButton(
              text: "Share Saraswathi Maiyam Students file",
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