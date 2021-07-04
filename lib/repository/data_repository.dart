import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kovilmaiyam/models/kovil.dart';

class Kovil1Repository {
  CollectionReference kovilCollection =  FirebaseFirestore.instance.collection('kovil');
  List<Kovil> kovilListFromDb = new List<Kovil>();

  Future<List<Kovil>> getKovilStream() async {
     QuerySnapshot querySnapshot = await kovilCollection.get();
     for(DocumentSnapshot documentSnaphot in querySnapshot.docs) {
      Kovil instKovil = Kovil.fromSnapshot(documentSnaphot);
      kovilListFromDb.add(instKovil);
     }
     return kovilListFromDb;
  }
}