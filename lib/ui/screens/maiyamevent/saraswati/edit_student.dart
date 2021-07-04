//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:kovilmaiyam/models/choices.dart' as choices;
import 'package:kovilmaiyam/ui/form/smart_select/features_header.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/ui/screens/maiyamevent/saraswati/new_event.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/models/saraswathi_student.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class EditStudentSheet extends StatelessWidget {
  Map<String, dynamic> studentjson;
  Kovil kovil;

  EditStudentSheet({Key key, this.studentjson, this.kovil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
              child: Text(
                'Edit Student',
              ),
            ),
            EditStudentSheetStateful(studentjson: studentjson, kovil: kovil),
          ],
        ),
      ),
      // bottomNavigationBar: Card(
      //   elevation: 3,
      //   margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      //   child: FeaturesTheme(),
      // ),
    );
  }
}

class EditStudentSheetStateful extends StatefulWidget {
  Map<String, dynamic> studentjson;
  Kovil kovil;

  EditStudentSheetStateful({Key key, this.studentjson, this.kovil}) : super(key: key);

  @override
  _EditStudentSheetStatefulState createState() => _EditStudentSheetStatefulState();
}

class _EditStudentSheetStatefulState extends State<EditStudentSheetStateful> {

  String _gender = 'male';
  String _tamilmonth = 'chithirai';
  String _nakshatra = 'poosam';
  bool _active = true;
  DateTime dateOfBirth = DateTime.now();

  final _nameController = TextEditingController();
  final parentNameController = TextEditingController();
  final contactNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Timestamp doB = widget.studentjson['date_of_birth'];
    _nameController.text = widget.studentjson['name'];
    parentNameController.text = widget.studentjson['parent_name'];
    contactNoController.text = widget.studentjson['contact_no'];
    dateOfBirth = doB.toDate();
    _gender = widget.studentjson['gender'];
    _tamilmonth = widget.studentjson['tamil_month_of_birth'];
    _nakshatra = widget.studentjson['nakshatra'];
    _active = widget.studentjson['active'] == 'Active' ? true : false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    if (picked != null && picked != dateOfBirth)
      setState(() {
        dateOfBirth = picked;
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    parentNameController.dispose();
    contactNoController.dispose();
    super.dispose();
  }

  String getGenderPrefix()
  {
    if(_gender == 'male') {
      return 'Master ';
    }
    else if(_gender == 'female') {
      return 'Miss ';
    }
    return ' ';
  }

  Future<void> updateStudent(SaraswathiStudent student) {
    return FirebaseFirestore.instance.collection('saraswathi_student').doc(widget.studentjson['id']).update(student.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        //const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Gender',
          value: _gender,
          choiceItems: choices.gender_type,
          onChange: (state) => setState(() => _gender = state.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              //leading: const CircleAvatar(
              //backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              //),
            );
          },
        ),
        //const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              controller: _nameController,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                //hintText: '',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                labelText: 'Name',
                prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date of Birth"),
              SizedBox(width: 20.0,),
              Text("${dateOfBirth.toLocal()}".split(' ')[0]),
              SizedBox(width: 20.0,),
              IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
        //const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Tamil Month of Birth',
          value: _tamilmonth,
          choiceItems: choices.tamilmonth_type,
          onChange: (state) => setState(() => _tamilmonth = state.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              //leading: const CircleAvatar(
              //backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              //),
            );
          },
        ),
        //const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Birth Nakshatra',
          value: _nakshatra,
          choiceItems: choices.nakshatra_type,
          onChange: (state) => setState(() => _nakshatra = state.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              //leading: const CircleAvatar(
              //backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              //),
            );
          },
        ),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              controller: parentNameController,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                //hintText: '',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                labelText: 'Parent\'s Name',
                prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              controller: contactNoController,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                //hintText: '',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                labelText: 'Contact Number',
                prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        //const Divider(indent: 20),
        /*
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date of Joining"),
              SizedBox(width: 20.0,),
              Text("${dateOfBirth.toLocal()}".split(' ')[0]),
              SizedBox(width: 20.0,),
              IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                //hintText: '',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                labelText: 'Name of School',
                prefixIcon: const Icon(Icons.school, color: Colors.teal,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                //hintText: '',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                labelText: 'Type of School',
                //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        */
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            children: [
              Text('Active'),
              Checkbox(value: _active, onChanged: (state) => setState(() => _active = !_active),),
            ],
          ),
        ),
        const Divider(indent: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 15.0),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  if(_nameController.text == null || _nameController.text.isEmpty || _nameController.text.trim().isEmpty) {
                    Dialogs.materialDialog(
                        msg: 'Student name cannot be empty.',
                        title: 'Add Name',
                        titleStyle: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                        barrierDismissible: false,
                        color: Colors.white,
                        context: context,
                        actions: [
                          IconsOutlineButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'OK',
                            //iconData: Icons.cancel_outlined,
                            //textStyle: TextStyle(color: Colors.red),
                            //iconColor: Colors.red,
                          ),
                        ]);
                  }
                  else {
                    SaraswathiStudent student = new SaraswathiStudent(widget.studentjson['kovil_id'], _nameController.text.trim(),
                        _gender, Timestamp.fromDate(dateOfBirth), _tamilmonth, _nakshatra,
                        widget.studentjson['date_of_joining'], parentNameController.text, contactNoController.text,
                        _active);
                    updateStudent(student);

                    Dialogs.bottomMaterialDialog(
                        msg: 'Updated student ' + _nameController.text + '.',
                        title: 'Success!',
                        titleStyle: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w900,
                          color: kSecondaryColor,
                        ),
                        animation: 'assets/lottie/success4.json',
                        barrierDismissible: false,
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
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SaraswathiNewEvent(kovil: widget.kovil),
                                ),
                              );
                            },
                            text: 'OK',
                            iconData: Icons.done,
                            color: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ]);
                  }
                },
                icon: Icon(Icons.send),
                label: Text('Submit'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}