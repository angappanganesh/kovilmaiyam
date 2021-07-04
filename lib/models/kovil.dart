import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_select/smart_select.dart' show S2Choice;

class Contact {
  String address;
  Contact(this.address);

  Map<String, dynamic> toMap() => {
    "address": this.address
  };

  Contact.fromMap(Map<dynamic, dynamic> map) :
        address = map["address"];
}

class Kovil {
  // 1
  String district;
  String zone;
  String ward;
  String name;
  Contact contact;
  String kovil_id;
  String password;
  String photos_url;
  String tagline;
  int id;

  // 3
  DocumentReference reference;

  // 4
  Kovil(this.district, this.zone, this.ward, this.name,
      this.contact, this.kovil_id, this.password, this.photos_url,
      this.tagline, {this.id});

  // 5
  factory Kovil.fromSnapshot(DocumentSnapshot snapshot) {
    Kovil newKovil = Kovil.fromJson(snapshot.data());
    newKovil.reference = snapshot.reference;
    return newKovil;
  }
  // 6
  factory Kovil.fromJson(Map<String, dynamic> json) => _KovilFromJson(json);

  // 7
  Map<String, dynamic> toJson() => _KovilToJson(this);

  @override
  String toString() => "Kovil<$name>";

  static String getCsvTitle()
  {
    return 'Kovil Id,Kovil Reference id,Kovil District,Kovil Zone,Kovil Ward,Kovil Name';
  }

  static String getCsvDetailTitle()
  {
    return 'Kovil Id,Kovil Reference id,Kovil District,Kovil Zone,Kovil Ward,Kovil Name,Kovil Address,Tagline,Photos URL';
  }

  String toCsvString() {
    String csvString = '';
    csvString += id != null ? '"' + id.toString() + '",' : '"",';
    csvString += '"' + reference.id + '",';
    csvString += district != null ? '"' + district + '",' : '"",';
    csvString += zone != null ? '"' + zone + '",' : '"",';
    csvString += ward != null ? '"' + ward + '",' : '"",';
    csvString += name != null ? '"' + kovil_id + '_' + name + '",' : '"",';
    return csvString;
  }

  String toCsvDetailString() {
    String csvString = '';
    csvString += id != null ? '"' + id.toString() + '",' : '"",';
    csvString += '"' + reference.id + '",';
    csvString += district != null ? '"' + district + '",' : '"",';
    csvString += zone != null ? '"' + zone + '",' : '"",';
    csvString += ward != null ? '"' + ward + '",' : '"",';
    csvString += name != null ? '"' + kovil_id + '_' + name + '",' : '"",';
    csvString += (contact != null && contact.address != null) ? '"' + contact.address + '",' : '"",';
    csvString += tagline != null ? '"' + tagline + '",' : '"",';
    csvString += photos_url != null ? '"' + photos_url + '",' : '"",';
    return csvString;
  }
}

Kovil _KovilFromJson(Map<String, dynamic> json) {
  Contact c = Contact.fromMap(json['contact']);
  return Kovil(
      json['district']  as String,
      json['zone'] as String,
      json['ward'] as String,
      json['name'] as String,
      c as Contact,
      json['kovil_id'] as String,
      json['password'] as String,
      (json['photos_url'] != null) ? json['photos_url'] : '' as String,
      (json['tagline'] != null) ? json['tagline'] : '' as String,
      id: json['id'] as int
  );
}

Map<String, dynamic> _KovilToJson(Kovil instance) => <String, dynamic> {
  'district': instance.district,
  'zone': instance.zone,
  'ward':instance.ward,
  'name': instance.name,
  'contact': instance.contact.toMap(),
  'kovil_id': instance.kovil_id,
  'password': instance.password,
  'photos_url': instance.photos_url,
  'tagline': instance.tagline,
  'id': instance.id,
};

class KovilContainer
{
  List<Kovil> kovilList;
  List<String> districts = new List<String>();
  Map<String, List<String>> zones = new Map<String, List<String>>(); // key = district
  Map<String, List<String>> wards = new Map<String, List<String>>(); // key = district+zone
  Map<String, List<Kovil>> kovils = new Map<String, List<Kovil>>(); // key = district+zone+ward

  KovilContainer(this.kovilList)
  {
    for(Kovil k in kovilList) {
      if(!districts.contains(k.district)) {
        districts.add(k.district);
      }

      if(!zones.containsKey(k.district)) {
        zones[k.district] = new List<String>();
      }
      if(!zones[k.district].contains(k.zone)) {
        zones[k.district].add(k.zone);
      }

      String wardKey = k.district+k.zone;
      if(!wards.containsKey(wardKey)) {
        wards[wardKey] = new List<String>();
      }
      if(!wards[wardKey].contains(k.ward)) {
        wards[wardKey].add(k.ward);
      }

      String kovilKey = k.district+k.zone+k.ward;
      if(!kovils.containsKey(kovilKey)) {
        kovils[kovilKey] = new List<Kovil>();
      }
      kovils[kovilKey].add(k);
    }
  }

  List<S2Choice<String>> getDistricts() {
    List<S2Choice<String>> choiceDistricts = new List<S2Choice<String>>();
    for(String d in districts) {
      choiceDistricts.add(S2Choice<String>(value: d, title: d));
    }
    return choiceDistricts;
  }

  List<S2Choice<String>> getZones(String district) {
    List<S2Choice<String>> choiceZones = new List<S2Choice<String>>();
    for(String z in zones[district]) {
      choiceZones.add(S2Choice<String>(value: z, title: z));
    }
    return choiceZones;
  }

  List<S2Choice<String>> getWards(String district, String zone) {
    List<S2Choice<String>> choiceWards = new List<S2Choice<String>>();
    for(String w in wards[district+zone]) {
      choiceWards.add(S2Choice<String>(value: w, title: w));
    }
    return choiceWards;
  }

  List<S2Choice<String>> getKovils(String district, String zone, String ward) {
    List<S2Choice<String>> choiceKovils = new List<S2Choice<String>>();
    for(Kovil kovil in kovils[district+zone+ward]) {
      choiceKovils.add(S2Choice<String>(value: kovil.id.toString(), title: kovil.kovil_id + '_' + kovil.name));
    }
    return choiceKovils;
  }

  bool ValidatePassword(int id, String password)
  {
    Kovil k = getKovilWithId(id);
    if(k == null)
      return false;
    return (k.password.compareTo(password) == 0);
  }

  Kovil getKovilWithId(int id)
  {
    for(Kovil kovil in kovilList) {
      if(kovil.id == id)
        return kovil;
    }
    return null;
  }

  Kovil getKovilWithKovilId(String kovil_id)
  {
    for(Kovil kovil in kovilList) {
      if(kovil.kovil_id.compareTo(kovil_id) == 0)
        return kovil;
    }
    return null;
  }
}
