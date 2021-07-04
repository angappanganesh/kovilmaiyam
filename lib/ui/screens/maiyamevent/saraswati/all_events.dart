import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kovilmaiyam/models/saraswathi_event.dart';
import 'package:kovilmaiyam/utils/under_construction.dart';
import 'package:smart_select/smart_select.dart';
import 'package:kovilmaiyam/ui/form/smart_select/features_header.dart';
import 'package:kovilmaiyam/ui/form/smart_select/keep_alive.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:kovilmaiyam/utils/constants.dart';
import 'package:kovilmaiyam/models/kovil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'add_student.dart';
import 'edit_student.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class SaraswathiAllEvents extends StatelessWidget {
  final Kovil kovil;

  const SaraswathiAllEvents({Key key, this.kovil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saraswati Maiyam Events'),
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
      body: FetchEventsAndList(kovil: kovil),
    );
  }
}

class FetchEventsAndList extends StatelessWidget {
  final Kovil kovil;

  const FetchEventsAndList({Key key, this.kovil}) : super(key: key);

  Future<List<SaraswathiEvent>> getEventsData() async {
    await Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("saraswathi_event")
        .get();
    List<SaraswathiEvent> eventsFromDB = new List<SaraswathiEvent>();
    snapshot.docs.forEach((DocumentSnapshot document) {
      SaraswathiEvent event = SaraswathiEvent.fromSnapshot(document);
      if(event.kovil_id == kovil.id)
        eventsFromDB.add(event);
    });
    eventsFromDB.sort((a, b) => b.class_date.compareTo(a.class_date));
    return eventsFromDB;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEventsData(),
      builder: (BuildContext context, AsyncSnapshot<List<SaraswathiEvent>> events) {
        if (events.hasError) {
          return Text('Something went wrong. Could not retrieve Event List!');
        }

        if(events.data == null) {
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
          return SaraswathiAllEventsStateful(events: events.data);
        }
      },
    );
  }

}

class SaraswathiAllEventsStateful extends StatefulWidget {
  final List<SaraswathiEvent> events;

  const SaraswathiAllEventsStateful({Key key, this.events}) : super(key: key);

  @override
  _SaraswathiAllEventsState createState() => new _SaraswathiAllEventsState();
}

class _SaraswathiAllEventsState extends State<SaraswathiAllEventsStateful> {

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kBackgroundColor,
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: widget.events.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  //child: YourListChild(),

                  child: AwesomeListItem(
                      title: dateAsTitle(widget.events[index].class_date.toDate()),
                      content: widget.events[index].no_of_students.toString(),
                      color: index.isEven ? kBlueColor : kSecondaryColor,
                      image: 'https://picsum.photos/' + (175 + index).toString(),
                      press: () {
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
                      },
                  ),

                ),
              ),
            );
          },
        ),
      ),
      /*
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: List.generate(
            100,
                (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: YourListChild(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      */
      /*
      body: new Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Text('All Sarawathi Maiyam Activities'),
          ),
          new Transform.translate(
            offset: new Offset(0.0, 30.0),
            child: new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return AwesomeListItem(
                    title: data[index]["title"],
                    content: data[index]["content"],
                    color: index.isEven ? kBlueColor : kSecondaryColor,
                    image: data[index]["image"]);
              },
            ),
          ),
          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              child: new ClipPath(
                clipper: new MyClipper(),
                child: new Stack(
                  children: [
                    new Image.network(
                      "https://picsum.photos/800/400?random",
                      fit: BoxFit.cover,
                    ),
                    new Opacity(
                      opacity: 0.2,
                      child: new Container(color: COLORS[3]),
                    ),
                    new Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: new ListTile(
                        leading: new CircleAvatar(
                          child: new Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4"),
                              ),
                            ),
                          ),
                        ),
                        title: new Text(
                          "Samarth Agarwal",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              letterSpacing: 2.0),
                        ),
                        subtitle: new Text(
                          "Lead Designer",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      */
    );
  }
}

class YourListChild extends StatelessWidget {

  @override

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          color: Colors.white70,
      ),
      /*
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.transparent,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              "https://www.pngkey.com/png/full/9-97414_white-pattern-png-clip-transparent-stock-triangle.png"),
        ),
      ),
      */
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          CircleAvatar(
            child: Text(new Random().nextInt(25).toString()),
            backgroundColor: kPrimaryColor,
          ),
          SizedBox(height: 16,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(new Random().nextInt(31).toString() + ' Jan 2021', style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w800
                ),),
                SizedBox(height: 6,),
                Text('Class on Olympics', style: Theme.of(context).textTheme.bodyText2,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;
  Function press;

  AwesomeListItem({this.title, this.content, this.color, this.image, this.press});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: widget.press,
      child: Row(
        children: <Widget>[
          new Container(width: 10.0, height: 190.0, color: widget.color),
          new Expanded(
            child: new Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white30,
                          minRadius: 25.0,
                          child: Center(
                            child: Text(
                              widget.content,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Text(
                          '  students',
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            height: 150.0,
            width: 150.0,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                new Transform.translate(
                  offset: new Offset(50.0, 0.0),
                  child: new Container(
                    height: 100.0,
                    width: 100.0,
                    color: widget.color,
                  ),
                ),
                new Transform.translate(
                  offset: Offset(10.0, 20.0),
                  child: new Card(
                    elevation: 20.0,
                    child: new Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 10.0,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}