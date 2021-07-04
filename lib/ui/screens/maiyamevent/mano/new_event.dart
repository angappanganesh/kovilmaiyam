import 'package:flutter/material.dart';
import 'package:kovilmaiyam/models/maiyam.dart';

import 'package:kovilmaiyam/ui/form/smart_select/features_header.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:kovilmaiyam/utils/under_construction.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:smart_select/smart_select.dart';
import 'package:kovilmaiyam/models/choices.dart' as choices;
import 'package:kovilmaiyam/utils/constants.dart';

class ManoNewEvent extends StatelessWidget {
  final Maiyam maiyam;

  const ManoNewEvent({Key key, this.maiyam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mano Maiyam'),
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
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnderConstructionScreen(),
                  ),
                );
              },
              icon: Icon(Icons.send),
              label: Text('SUBMIT'),
            ),
          ],
        ),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              KeepAliveWidget(
                child: StickyHeader(
                  header: const FeaturesHeader('Record Mano Maiyam Activity'),
                  content: FeaturesSingleSheet(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturesSingleSheet extends StatefulWidget {
  @override
  _FeaturesSingleSheetState createState() => _FeaturesSingleSheetState();
}

class _FeaturesSingleSheetState extends State<FeaturesSingleSheet> {

  String _activityType = 'yoga';
  DateTime selectedDate = DateTime.now();
  //String _hero = 'iro';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Activity Type',
          value: _activityType,
          choiceItems: choices.mano_activity_type,
          onChange: (state) => setState(() => _activityType = state.value),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
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
        const Divider(indent: 20),
        ...getSubActivityWidget(),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date of Activity"),
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
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)
              ),
              //hintText: '',
              labelText: 'No of Men Participants',
              //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
              prefixText: ' ',
              suffixText: '#',
              suffixStyle: const TextStyle(color: Colors.green),
            ),
          ),
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)
              ),
              //hintText: '',
              labelText: 'No of Women Participants',
              //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
              prefixText: ' ',
              suffixText: '#',
              suffixStyle: const TextStyle(color: Colors.green),
            ),
          ),
        ),
        const Divider(indent: 20),
        Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)
              ),
              //hintText: '',
              labelText: 'No of Child Participants',
              //prefixIcon: const Icon(Icons.person, color: Colors.blue,),
              prefixText: ' ',
              suffixText: '#',
              suffixStyle: const TextStyle(color: Colors.green),
            ),
          ),
        ),
        const SizedBox(height: 7),
      ],
    );
  }

  List<Widget> getSubActivityWidget()
  {
    if(_activityType == 'other')
      return [Padding(padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: TextField(
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)
              ),
              //hintText: '',
              //helperText: 'If more than one trainer, separate with semicolon ;',
              labelText: 'Details',
              //prefixIcon: const Icon(Icons.person, color: Colors.green,),
              prefixText: ' ',
              //suffixText: 'USD',
              //suffixStyle: const TextStyle(color: Colors.green)
            ),
          )
      )];
    else
      return [];
  }
}
