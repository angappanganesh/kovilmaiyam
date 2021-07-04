import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'kovil.dart';

class SaraswathiStudent {
  // 1
  int kovil_id;
  String name;
  String gender;
  Timestamp date_of_birth;
  String tamil_month_of_birth;
  String nakshatra;
  Timestamp date_of_joining;
  String parent_name;
  String contact_no;
  bool active;

  // 3
  DocumentReference reference;

  // 4
  SaraswathiStudent(this.kovil_id, this.name, this.gender, this.date_of_birth, this.tamil_month_of_birth,
       this.nakshatra, this.date_of_joining, this.parent_name, this.contact_no, this.active);

  // 5
  factory SaraswathiStudent.fromSnapshot(DocumentSnapshot snapshot) {
    SaraswathiStudent newStudent = SaraswathiStudent.fromJson(snapshot.data());
    newStudent.reference = snapshot.reference;
    return newStudent;
  }
  // 6
  factory SaraswathiStudent.fromJson(Map<String, dynamic> json) => _StudentFromJson(json);

  // 7
  Map<String, dynamic> toJson() => _StudentToJson(this);
  Map<String, dynamic> toPlainJson() => _StudentToPlainJson(this);

  @override
  String toString() => "SaraswathiStudent<$name>";

  static String getCsvTitle() {
    return 'Kovil Id,Student Reference Id,Student Name,Gender,Date of birth,Tamil month of birth,Nakshatram,Date of joining,Parent Name,Contact Number,IsActive';
  }

  static String getCsvTitleWithKovilDetails() {
    return Kovil.getCsvTitle() + ',Student Reference Id,Student Name,Gender,Date of birth,Tamil month of birth,Nakshatram,Date of joining,Parent Name,Contact Number,IsActive';
  }

  String toCsvString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String csvString = '';
    csvString += kovil_id != null ? '"' + kovil_id.toString() + '",' : '"",';
    csvString += '"' + reference.id + '",';
    csvString += name != null ? '"' + name + '",' : '"",';
    csvString += gender != null ? '"' + gender + '",' : '"",';
    csvString += date_of_birth != null ? '"' + formatter.format(date_of_birth.toDate()) + '",' : '"",';
    csvString += tamil_month_of_birth != null ? '"' + tamil_month_of_birth + '",' : '"",';
    csvString += nakshatra != null ? '"' + nakshatra + '",' : '"",';
    csvString += date_of_joining != null ? '"' + formatter.format(date_of_joining.toDate()) + '",' : '"",';
    csvString += parent_name != null ? '"' + parent_name + '",' : '"",';
    csvString += contact_no != null ? '"' + contact_no + '",' : '"",';
    csvString += active != null ? '"' + active.toString() + '",' : '"",';
    return csvString;
  }

  String toCsvStringWithKovilDetails(Kovil kovil) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String csvString = '';
    //csvString += kovil_id != null ? '"' + kovil_id.toString() + '",' : '"",';
    // kovil_id should never be null or unequal to kovil.id. Update the number of "" anyway if the no of csv columns increases
    csvString += (kovil_id != null && kovil != null && kovil.id == kovil_id) ? kovil.toCsvString() : '"","","","","","",';
    csvString += '"' + reference.id + '",';
    csvString += name != null ? '"' + name + '",' : '"",';
    csvString += gender != null ? '"' + gender + '",' : '"",';
    csvString += date_of_birth != null ? '"' + formatter.format(date_of_birth.toDate()) + '",' : '"",';
    csvString += tamil_month_of_birth != null ? '"' + tamil_month_of_birth + '",' : '"",';
    csvString += nakshatra != null ? '"' + nakshatra + '",' : '"",';
    csvString += date_of_joining != null ? '"' + formatter.format(date_of_joining.toDate()) + '",' : '"",';
    csvString += parent_name != null ? '"' + parent_name + '",' : '"",';
    csvString += contact_no != null ? '"' + contact_no + '",' : '"",';
    csvString += active != null ? '"' + active.toString() + '",' : '"",';
    return csvString;
  }
}

SaraswathiStudent _StudentFromJson(Map<String, dynamic> json) {
  return SaraswathiStudent(
      json['kovil_id']  as int,
      json['name'] as String,
      json['gender'] as String,
      json['date_of_birth'] as Timestamp,
      json['tamil_month_of_birth']  as String,
      json['nakshatra'] as String,
      json['date_of_joining'] as Timestamp,
      json['parent_name'] as String,
      json['contact_no'] as String,
      json['active'] as bool
  );
}

Map<String, dynamic> _StudentToJson(SaraswathiStudent instance) => <String, dynamic> {
  'kovil_id': instance.kovil_id,
  'name':instance.name,
  'gender':instance.gender,
  'date_of_birth': instance.date_of_birth,
  'tamil_month_of_birth': instance.tamil_month_of_birth,
  'nakshatra': instance.nakshatra,
  'date_of_joining': instance.date_of_joining,
  'parent_name': instance.parent_name,
  'contact_no': instance.contact_no,
  'active': instance.active,
};

Map<String, dynamic> _StudentToPlainJson(SaraswathiStudent instance) {
  int max = 100;
  int random = Random().nextInt(max);
  String pic = (instance.gender == 'male') ? "men/" : "women/";
  pic += random.toString();
  return <String, dynamic> {
    'id': instance.reference.id,
    'kovil_id': instance.kovil_id,
    'name': instance.name,
    'gender': instance.gender,
    'date_of_birth': instance.date_of_birth,
    'tamil_month_of_birth': instance.tamil_month_of_birth,
    'nakshatra': instance.nakshatra,
    'date_of_joining': instance.date_of_joining,
    'parent_name': instance.parent_name,
    'contact_no': instance.contact_no,
    'active': instance.active ? 'Active' : 'Inactive',
    "picture": {
      "large": "https://randomuser.me/api/portraits/" + pic + ".jpg",
      "medium": "https://randomuser.me/api/portraits/med/" + pic + ".jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/" + pic + ".jpg"
    }
  };
}