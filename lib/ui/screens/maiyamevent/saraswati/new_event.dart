import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kovilmaiyam/models/choices.dart';
import 'package:kovilmaiyam/models/saraswathi_event.dart';
import 'package:kovilmaiyam/utils/success.dart';
import 'package:smart_select/smart_select.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_header.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:kovilmaiyam/models/saraswathi_student.dart';
import 'add_student.dart';
import 'edit_student.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class SaraswathiNewEvent extends StatelessWidget {
  final Kovil kovil;

  const SaraswathiNewEvent({Key key, this.kovil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saraswati Maiyam'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.home,
              color: kBackgroundColor,
            ),
            label: Text(''),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
              child: Text(
                'Record Saraswati Maiyam Activity',
              ),
            ),
            FetchStudentsAndShowForm(kovil: kovil),
          ],
        ),
      ),
    );
  }
}

class FetchStudentsAndShowForm extends StatelessWidget {
  final Kovil kovil;

  const FetchStudentsAndShowForm({Key key, this.kovil}) : super(key: key);

  Future<List<SaraswathiStudent>> getStudentsData() async {
    await Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("saraswathi_student")
        .get();
    List<SaraswathiStudent> studentsFromDB = new List<SaraswathiStudent>();
    snapshot.docs.forEach((DocumentSnapshot document) {
      SaraswathiStudent student = SaraswathiStudent.fromSnapshot(document);
      if(student.kovil_id == kovil.id)
        studentsFromDB.add(student);
    });
    return studentsFromDB;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStudentsData(),
      builder: (BuildContext context, AsyncSnapshot<List<SaraswathiStudent>> students) {
        if (students.hasError) {
          return Text('Something went wrong. Could not retrieve Student List!');
        }

        if(students.data == null) {
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
        else {
          return AttendanceSheetStateful(kovil: kovil, students: students.data);
        }
      },
    );
  }

}

class AttendanceSheetStateful extends StatefulWidget {
  final Kovil kovil;
  final List<SaraswathiStudent> students;

  const AttendanceSheetStateful({Key key, this.kovil, this.students}) : super(key: key);

  @override
  _AttendanceSheetStatefulState createState() => _AttendanceSheetStatefulState();
}

class _AttendanceSheetStatefulState extends State<AttendanceSheetStateful> {

  DateTime selectedDate = DateTime.now();
  List<String> _attendedStudentIds = [];
  List<S2Choice<String>> _students = [];
  bool _studentsIsLoading = false;
  final commentsController = TextEditingController();

  ThemeData get theme => Theme.of(context);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    commentsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<DocumentReference> addEvent(SaraswathiEvent event) {
    return FirebaseFirestore.instance.collection('saraswathi_event').add(event.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 7),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Class Date"),
              SizedBox(width: 20.0,),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              SizedBox(width: 20.0,),
              IconButton(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
        const Divider(indent: 20),
        //const SizedBox(height: 7),
        Padding(
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: Text(
            'Student List',
          ),
        ),
        //const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: RaisedButton.icon(
            color: Colors.white70,
            icon: Icon(Icons.add),
            label: Text('Add Student'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentSheet(
                    kovil: widget.kovil,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 7),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Select Students',
          value: _attendedStudentIds,
          onChange: (state) => setState(() => _attendedStudentIds = state.value),
          modalFilter: true,
          choiceItems: _students,
          choiceGrouped: true,
          choiceLayout: S2ChoiceLayout.grid,
          choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 2
          ),
          choiceBuilder: (context, choice, query) {
            return Card(
              color: choice.selected ? theme.primaryColor : theme.cardColor,
              child: InkWell(
                onTap: () {
                  String active = choice.meta['active'];
                  if( active.compareTo('Active') == 0)
                    choice.select(!choice.selected);
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          //backgroundImage: NetworkImage(choice.meta['picture']['large']),
                          child: Center(
                            child: Text(
                              choice.meta['name'].toString().split(' ').map((e) => (e == null || e.isEmpty) ? '' : e[0].toUpperCase()).join(),
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        choice.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: choice.selected ? Colors.white : null,
                          height: 1,
                        ),
                      ),
                      FlatButton(
                        child: const Text('Edit'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudentSheet(
                                  studentjson: choice.meta,
                                  kovil: widget.kovil,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isLoading: _studentsIsLoading,
              hideValue: true,
              leading: CircleAvatar(
                backgroundColor: theme.primaryColor,
                child: Text(
                    state.value?.length?.toString() ?? '0',
                    style: TextStyle(color: Colors.white)
                ),
              ),
              body: S2TileChips(
                chipLength: state.valueObject.length,
                chipLabelBuilder: (context, i) {
                  return Text(state.valueObject[i].title);
                },
                chipAvatarBuilder: (context, i) => CircleAvatar(
                    backgroundImage: NetworkImage(state.valueObject[i].meta['picture']['thumbnail'])
                ),
                chipOnDelete: (i) {
                  setState(() => _attendedStudentIds.remove(state.valueObject[i].value));
                },
                chipColor: Theme.of(context).primaryColor,
                chipRaised: true,
                placeholder: Container(),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextField(
              maxLines: 3,
              controller: commentsController,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
                hintText: 'Add comments here...',
                //helperText: 'If more than one trainer, separate with semicolon ;',
                //labelText: 'Name',
                //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                //prefixText: getGenderPrefix(),
                //suffixText: 'USD',
                //suffixStyle: const TextStyle(color: Colors.green)
              ),
            )
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
              child: FloatingActionButton.extended(
                backgroundColor: kPrimaryColor,
                heroTag: null,
                onPressed: () {
                  if(_attendedStudentIds == null || _attendedStudentIds.length == 0) {
                    Dialogs.materialDialog(
                        msg: 'No Students are marked for attendance. Are you sure?',
                        title: 'Look Again!',
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
                            text: 'Cancel',
                            iconData: Icons.cancel_outlined,
                            textStyle: TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          ),
                          IconsButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SaraswathiEvent event = new SaraswathiEvent(Timestamp.fromDate(selectedDate), widget.kovil.id,
                                  _attendedStudentIds.length, _attendedStudentIds, commentsController.text);
                              addEvent(event);
                              Dialogs.bottomMaterialDialog(
                                  msg: 'Added new classroom event conducted on ' + dateAsTitle(selectedDate) +
                                      ' with ' + _attendedStudentIds.length.toString() + ' student(s).',
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
,l
                                        iconColor: Colors.grey,
                                      ),
                                      */
                                      IconsButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                                    /*
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SaraswathiNewEvent(kovil: widget.kovil),
                                          ),
                                        );
                                        */
                                      },
                                      text: 'OK',
                                      iconData: Icons.done,
                                      color: Colors.green,
                                      textStyle: TextStyle(color: Colors.white),
                                      iconColor: Colors.white,
                                    ),
                                  ]);
                            },
                            text: 'Go ahead',
                            iconData: Icons.done,
                            color: Colors.green,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ]);
                  }
                  else {
                    SaraswathiEvent event = new SaraswathiEvent(Timestamp.fromDate(selectedDate), widget.kovil.id,
                        _attendedStudentIds.length, _attendedStudentIds, commentsController.text);
                    addEvent(event);
                    Dialogs.bottomMaterialDialog(
                        msg: 'Added new classroom event conducted on ' + dateAsTitle(selectedDate) +
                            ' with ' + _attendedStudentIds.length.toString() + ' student(s).',
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
                              /*
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SaraswathiNewEvent(kovil: widget.kovil),
                                          ),
                                        );
                                        */
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
                label: Text('Submit Attendance'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  initState() {
    super.initState();

    //_getUsers();
    _getStudents();
  }

  void _getStudents() async {
    List<Map<String, dynamic>> studentsForUI = [];
    widget.students.forEach((element) {
      studentsForUI.add(element.toPlainJson());
    });
    try {
      setState(() => _studentsIsLoading = true);
      setState(() => _students = S2Choice.listFrom<String, dynamic>(
        source: studentsForUI,
        value: (index, item) => item['id'],
        title: (index, item) => item['name'],
        subtitle: (index, item) => item['nakshatra'],
        group: (index, item) => item['active'],
        meta: (index, item) => item,
      ));
    } catch (e) {
      print(e);
    } finally {
      setState(() => _studentsIsLoading = false);
    }
  }
  /*
  void _getUsers() async {
    try {
      setState(() => _usersIsLoading = true);
      //String url = "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      //Response res = await Dio().get(url);
      setState(() => _users = S2Choice.listFrom<int, dynamic>(
        source: [{"id":1, "gender":"female",
          "name":{"title":"Ms","first":"Nivethitha","last":"Vishali"},
          "email":"bala.murali@example.com",
          "picture":{
            "large":"https://randomuser.me/api/portraits/women/85.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/85.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/85.jpg"
          },"nat":"GB", "active":"Active"},
          {"id":2, "gender":"female",
            "name":{"title":"Ms","first":"Suseela","last":"Angappan"},
            "email":"nivethitha.vishali32@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/women/9.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/9.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/9.jpg"
          },"nat":"NL", "active":"Active"},
          {"id":3, "gender":"male",
            "name":{"title":"Mr","first":"Sabarisastha","last":"Ramanathan"},
            "email":"anthony.malmo@example.com",
            "picture":{"large":"https://randomuser.me/api/portraits/men/85.jpg",
              "medium":"https://randomuser.me/api/portraits/med/men/85.jpg",
              "thumbnail":"https://randomuser.me/api/portraits/thumb/men/85.jpg"
            },"nat":"NO", "active":"Active"},
          {"id":4, "gender":"female","name":{"title":"Madame","first":"Vidhya","last":"Venkat"},
            "email":"olga.adam@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/59.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/59.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/59.jpg"
          },"nat":"CH", "active":"Active"},
          {"id":5, "gender":"male","name":{"title":"Mr","first":"Ganesh","last":"Angappan"},
            "email":"oscar.kristensen@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/men/18.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/18.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/18.jpg"
          },"nat":"DK", "active":"Discontinued"},
          {"id":6, "gender":"male","name":{"title":"Mr","first":"Venkata","last":"Velayutham"},
            "email":"fahim.adriaensen@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/men/92.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/92.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/92.jpg"
          },"nat":"NL", "active":"Discontinued"},
          {"id":7, "gender":"female","name":{"title":"Miss","first":"Krishna",
            "last":"Veni"},"email":"savannah.thompson@example.com",
            "picture":{"large":
            "https://randomuser.me/api/portraits/women/61.jpg",
              "medium":"https://randomuser.me/api/portraits/med/women/61.jpg",
              "thumbnail":"https://randomuser.me/api/portraits/thumb/women/61.jpg"
            },"nat":"NZ", "active":"Active"},
          {"id":8, "gender":"male","name":{"title":"Mr","first":"Ramvishruthan","last":"Ganesh"},
            "email":"bjarne.bergstra@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/men/48.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/48.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/48.jpg"
          },"nat":"NL", "active":"Active"},
          {"id":9, "gender":"male","name":
          {"title":"Mr","first":"Akshiv","last":"Angappan"},
            "email":"leroy.bailey@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/men/12.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/12.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/12.jpg"
          },"nat":"IE", "active":"Active"},
          {"id":10, "gender":"female","name":{"title":"Ms","first":"Gugameena","last":"Saraswathy"},
            "email":"violet.dean@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/women/24.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/24.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/24.jpg"},
            "nat":"AU", "active":"Active"},
          {"id":11, "gender":"female","name":{"title":"Ms","first":"Menaka","last":"Senthilvel"},
            "email":"julia.rantala@example.com",
            "picture":{"large":"https://randomuser.me/api/portraits/women/58.jpg",
              "medium":"https://randomuser.me/api/portraits/med/women/58.jpg",
              "thumbnail":"https://randomuser.me/api/portraits/thumb/women/58.jpg"},
            "nat":"FI", "active":"Discontinued"},
          {"id":12, "gender":"female","name":{"title":"Ms","first":"Indumathy","last":"R"},
            "email":"corine.santegoets@example.com",
            "picture":{
              "large":"https://randomuser.me/api/portraits/women/24.jpg",
              "medium":"https://randomuser.me/api/portraits/med/women/24.jpg",
              "thumbnail":"https://randomuser.me/api/portraits/thumb/women/24.jpg"
            },"nat":"NL", "active":"Discontinued"},
          {"id":13, "gender":"female","name":{"title":"Ms","first":"Valar","last":"Mathy"},
            "email":"marcella.palm@example.com","picture":
          {"large":"https://randomuser.me/api/portraits/women/29.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/29.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/29.jpg"},
            "nat":"DE", "active":"Active"},
          {"id":14, "gender":"male","name":{"title":"Mr","first":"Nitin","last":"Shanmugham"},
            "email":"wallace.murray@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/men/48.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/48.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/48.jpg"},
            "nat":"IE", "active":"Active"},
          {"id":15, "gender":"male","name":{"title":"Mr","first":"Sudarson","last":"Annamalai"},
            "email":"nico.hammero@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/men/49.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/49.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/49.jpg"
          },"nat":"NO", "active":"Discontinued"},
          {"id":16, "gender":"male","name":{"title":"Mr","first":"Hari","last":"Krishnan"},
            "email":"andre.farragher@example.com","picture":{"large":
          "https://randomuser.me/api/portraits/men/82.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/82.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/82.jpg"},
            "nat":"IE", "active":"Active"},
          {"id":17, "gender":"male","name":{"title":"Mr","first":"Saravanan","last":"N"},
            "email":"kacper.trinh@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/men/70.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/70.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/70.jpg"},
            "nat":"NO", "active":"Discontinued"},
          {"id":18, "gender":"female","name":{"title":"Ms","first":"Sangeetha","last":"Valli"},
            "email":"maya.roger@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/54.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/54.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/54.jpg"
          },"nat":"FR", "active":"Discontinued"},
          {"id":19, "gender":"female","name":{"title":"Miss","first":"Muthu","last":"Varshini"},
            "email":"caitlin.kelley@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/62.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/62.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/62.jpg"},
            "nat":"IE", "active":"Active"},
          {"id":20, "gender":"female","name":{"title":"Mrs","first":"Soundari","last":"Kannappan"},
            "email":"heidi.frazier@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/85.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/85.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/85.jpg"},
            "nat":"US", "active":"Active"},
          {"id":21, "gender":"female","name":{
            "title":"Mrs","first":"Deivanai","last":"Aaya"},
            "email":"claudia.dean@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/38.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/38.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/38.jpg"},
            "nat":"AU", "active":"Discontinued"},
          {"id":22, "gender":"female","name":{"title":"Miss","first":"Priya","last":"Kanna"},
            "email":"nadia.campos@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/76.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/76.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/76.jpg"},
            "nat":"BR", "active":"Active"},
          {"id":23, "gender":"female","name":{"title":"Ms","first":"Kaveri","last":"Anu"},
            "email":"sofie.pedersen@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/88.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/88.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/88.jpg"
          },"nat":"DK", "active":"Active"},
          {"id":24, "gender":"male","name":{"title":"Mr","first":"Prabhu","last":"Kumarappan"},
            "email":"gregory.dunn@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/men/34.jpg",
            "medium":"https://randomuser.me/api/portraits/med/men/34.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/men/34.jpg"},
            "nat":"US", "active":"Active"},
          {"id":25, "gender":"female","name":{"title":"Mrs","first":"Bama","last":"Lama"},
            "email":"eleanor.lewis@example.com","picture":{
            "large":"https://randomuser.me/api/portraits/women/46.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/46.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/46.jpg"},
            "nat":"AU", "active":"Active"}],//res.data['results'],
        value: (index, item) => item['id'],
        title: (index, item) => item['name']['first'] + ' ' + item['name']['last'],
        subtitle: (index, item) => item['email'],
        group: (index, item) => item['active'],
        meta: (index, item) => item,
      ));
    } catch (e) {
      print(e);
    } finally {
      setState(() => _usersIsLoading = false);
    }
  }
  */
}