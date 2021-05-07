import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coopscmconsole/widget/alertsave.dart';
import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  final String nombre;
  Test2({this.nombre});

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    CollectionReference user =
        FirebaseFirestore.instance.collection('Usuarios');
    return Scaffold(
      appBar: AppBar(
        title: Text('Socios'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.orange[150],
              border: Border.all(color: Colors.red[900], width: 3.0),
              borderRadius: BorderRadius.circular(10.0),


            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: user.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();

                return DataTable(columns: [
                  DataColumn(label: Text('Socio')),
                 
                  DataColumn(
                    label: Text('Nombre'),
                  ),
                  DataColumn(label: Text('DNI')),
                ], rows: _buildList(context, snapshot.data.docs));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    return DataRow(
      cells: [
        DataCell(Text(data.data()['socio'])),
       
        DataCell(Text(data.data()['nombre']), onTap: () async {
          await showTextDialog(context,
              title: 'Ingresar datos de consumo para ${data.data()['nombre']}',
              value: data.data()['userId'].toString());
        }),
        DataCell(Text(data.data()['DNI'])),
      ],
    );
  }

 
}
