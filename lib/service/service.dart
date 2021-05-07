import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:coopscmconsole/model/users.dart';
import 'package:flutter/material.dart';

class FirestoreService extends StatelessWidget {
  CollectionReference _db = FirebaseFirestore.instance.collection('Usuarios');

  Future<void> saveUsuario(Usuario usuario) {
    return _db.doc(usuario.soci).set(usuario.toMap(), SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  //Stream<List<Usuario>> getUsuario() {
  //return _db.collection('Usuario').snapshots().map((snapshot) =>
  //   snapshot.docs.map((document) => Usuario.fromFirestore(document.data)).toList());
  //}

//Stream<List<Putos>> getUsuario() {
//    return _db.snapshots().map((snapshot) => snapshot.docs
//        .map((document) => Putos.fromFirestore(document.data()))
//        .toList());
 // }

  
}
