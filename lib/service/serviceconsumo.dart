import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coopscmconsole/model/consumo.dart';
import 'package:flutter/material.dart';

class FirestoreConsumo extends StatelessWidget {
  CollectionReference _db = FirebaseFirestore.instance
      .collection('Usuarios')
      ;

  

  Future<void> saveConsumo(Consumo consumer) {
    return _db
        .doc(consumer.userid)
        .collection('periodo')
        .doc(consumer.periodo)
        .set(consumer.toMap(), SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}
