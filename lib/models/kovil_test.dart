import 'package:smart_select/smart_select.dart' show S2Choice;

class ContactDetails
{
  String address, phone, email;
  ContactDetails(this.address, this.phone, {this.email:''});
}

class Admin
{
  String name;
  ContactDetails contact;
  bool isPrimary;
  Admin(this.name, this.contact, this.isPrimary);
}

class KovilTest
{
  int id;
  String city, district, zone, ward, kovil_id, kovil_name, tagline, password;
  ContactDetails contact;
  List<Admin> admins;
  KovilTest(this.id, this.city, this.district, this.zone,
      this.ward, this.kovil_id, this.kovil_name, this.tagline, this.password, this.contact, this.admins);
}

class KovilTestContainer
{
  List<KovilTest> kovilTests;
  List<String> districts = new List<String>();
  Map<String, List<String>> zones = new Map<String, List<String>>(); // key = district
  Map<String, List<String>> wards = new Map<String, List<String>>(); // key = district+zone
  Map<String, List<KovilTest>> kovils = new Map<String, List<KovilTest>>(); // key = district+zone+ward

  KovilTestContainer(this.kovilTests)
  {
    for(KovilTest k in kovilTests) {
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
        kovils[kovilKey] = new List<KovilTest>();
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
    for(KovilTest kovil in kovils[district+zone+ward]) {
      choiceKovils.add(S2Choice<String>(value: kovil.id.toString(), title: kovil.kovil_id + '_' + kovil.kovil_name));
    }
    return choiceKovils;
  }

  bool ValidatePassword(int id, String password)
  {
    KovilTest k = getKovilWithId(id);
    if(k == null)
      return false;
    return (k.password.compareTo(password) == 0);
  }

  KovilTest getKovilWithId(int id)
  {
    for(KovilTest kovil in kovilTests) {
      if(kovil.id == id)
        return kovil;
    }
    return null;
  }

  KovilTest getKovilWithKovilId(String kovil_id)
  {
    for(KovilTest kovil in kovilTests) {
      if(kovil.kovil_id.compareTo(kovil_id) == 0)
        return kovil;
    }
    return null;
  }
}