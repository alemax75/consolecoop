import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Socios')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Usuarios').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return DataTable(columns: [
          DataColumn(label: Text('Socio')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('DNI')),
          DataColumn(label: Text('Direccion')),          
          DataColumn(label: Text('Telefono')),
          DataColumn(label: Text('Email')),                         
         
        ], rows: _buildList(context, snapshot.data.docs));
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    
    return DataRow(cells: [
      DataCell(Text(data.data()['socio'])),
      DataCell(Text(data.data()['nombre'])),
      DataCell(Text(data.data()['DNI'])),
      DataCell(Text(data.data()['direccion'])),            
      DataCell(Text(data.data()['telefono'])),
      DataCell(Text(data.data()['email'])),   
      
      
    ]);
  }
}
