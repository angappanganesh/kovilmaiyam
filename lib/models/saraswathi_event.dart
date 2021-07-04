import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'kovil.dart';

class SaraswathiEvent {
  // 1
  Timestamp class_date;
  int kovil_id;
  int no_of_students;
  List<String> student_ids;
  String comments;

  // 3
  DocumentReference reference;

  // 4
  SaraswathiEvent(this.class_date, this.kovil_id,
      this.no_of_students, this.student_ids, this.comments);

  // 5
  factory SaraswathiEvent.fromSnapshot(DocumentSnapshot snapshot) {
    SaraswathiEvent newEvent = SaraswathiEvent.fromJson(snapshot.data());
    newEvent.reference = snapshot.reference;
    return newEvent;
  }
  // 6
  factory SaraswathiEvent.fromJson(Map<String, dynamic> json) => _EventFromJson(json);

  // 7
  Map<String, dynamic> toJson() => _EventToJson(this);

  @override
  String toString() => "SaraswathiEvent<$class_date>";

  static String getCsvTitle() {
    return 'Kovil Id,Event Reference Id,Class Date,Number of Students,Attended Student Ids,Comments';
  }

  static String getCsvTitleWithKovilDetails() {
    return Kovil.getCsvTitle() + ',Event Reference Id,Class Date,Number of Students,Attended Student Ids,Comments';
  }

  String toCsvString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String csvString = '';
    csvString += kovil_id != null ? '"' + kovil_id.toString() + '",' : '"",';
    csvString += '"' + reference.id + '",';
    csvString += class_date != null ? '"' + formatter.format(class_date.toDate()) + '",' : '"",';
    csvString += no_of_students != null ? '"' + no_of_students.toString() + '",' : '"",';
    csvString += student_ids != null ? '"' + student_ids.join(',') + '",' : '"",';
    csvString += comments != null ? '"' + comments + '"' : '""';
    return csvString;
  }

  String toCsvStringWithKovilDetails(Kovil kovil) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String csvString = '';
    // kovil_id should never be null or unequal to kovil.id. Update the number of "" anyway if the no of csv columns increases
    csvString += (kovil_id != null && kovil != null && kovil.id == kovil_id) ? kovil.toCsvString() : '"","","","","","",';
    csvString += '"' + reference.id + '",';
    csvString += class_date != null ? '"' + formatter.format(class_date.toDate()) + '",' : '"",';
    csvString += no_of_students != null ? '"' + no_of_students.toString() + '",' : '"",';
    csvString += student_ids != null ? '"' + student_ids.join(',') + '",' : '"",';
    csvString += comments != null ? '"' + comments + '"' : '""';
    return csvString;
  }
}

SaraswathiEvent _EventFromJson(Map<String, dynamic> json) {
  List<dynamic> dynList = json['student_ids'];
  List<String> strList = new List<String>();
  dynList.forEach((element) {strList.add(element.toString());});
  return SaraswathiEvent(
      json['class_date']  as Timestamp,
      json['kovil_id'] as int,
      json['no_of_students'] as int,
      strList,
      json['comments'] as String
  );
}

Map<String, dynamic> _EventToJson(SaraswathiEvent instance) => <String, dynamic> {
  'class_date': instance.class_date,
  'kovil_id': instance.kovil_id,
  'no_of_students':instance.no_of_students,
  'student_ids': instance.student_ids,
  'comments': instance.comments,
};