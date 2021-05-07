import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coopscmconsole/model/users.dart';
import 'package:coopscmconsole/service/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SaveUsers extends StatefulWidget {
  @override
  _SaveUsersState createState() => _SaveUsersState();
}

class _SaveUsersState extends State<SaveUsers> {
  final direccion = TextEditingController();
  final telefone = TextEditingController();
  final socio = TextEditingController();
  final dni = TextEditingController();
  final nombre = TextEditingController();
  final nmedidor = TextEditingController();
  final lecturaant = TextEditingController();
  final lecturaact = TextEditingController();
  final kilowats = TextEditingController();
  final totalpesos = TextEditingController();
  final zona = TextEditingController();
  final mensaje = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference user =
        FirebaseFirestore.instance.collection('Usuarios');
    final _formKey = GlobalKey<FormState>();

    final firestoreService = FirestoreService();

    saveUsuario() {
      var nuevoUsuario = Usuario(
        userId: FirebaseAuth.instance.currentUser.uid,
        dir: direccion.text,
        tel: telefone.text,
        soci: socio.text,
        dnii: dni.text,
      );

      firestoreService.saveUsuario(nuevoUsuario);
    }

   

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuarios'),
      ),
      resizeToAvoidBottomInset: false,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange[700], width: 4.0),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            width: 500,
            child: StreamBuilder<QuerySnapshot>(
              stream: user.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();

                return DataTable(columns: [
                  DataColumn(label: Text('Socio')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('DNI')),
                ], rows: _buildList(context, snapshot.data.docs));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo, width: 4.0),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            width: 400,
            child: Column(
              children: <Widget>[
                Text('hola'),
                Text(
                  'Ingresar consumo del socio',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: false,
                          controller: nombre,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: '04/21',
                            icon: Icon(
                              Icons.date_range_outlined,
                              size: 20.0,
                            ),
                            labelText: 'Periodo',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar periodo';
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: socio,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.account_circle,
                              size: 20.0,
                            ),
                            labelText: 'Numero de socio',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar n. socio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: telefone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.phone_android,
                              size: 20.0,
                            ),
                            labelText: 'Telefono',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar Telefono';
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: direccion,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_city,
                              size: 20.0,
                            ),
                            labelText: 'Direccion',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar Direccion';
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.phone_android,
                              size: 20.0,
                            ),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar Telefono';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: dni,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              size: 20.0,
                            ),
                            labelText: 'D.N.I',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'por favor ingresar DNI';
                            }
                            return null;
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Procesando')));
                                Navigator.of(context).pop();
                                saveUsuario();
                              }

                              return null;
                            },
                            child: Text('Actualizar'),
                          ),
                        ),
                        //Text(snapshot.data.displayName),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<DataRow> _buildList(
    BuildContext context, List<DocumentSnapshot> snapshot) {
  return snapshot.map((data) => _buildListItem(context, data)).toList();
}

DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
  return DataRow(cells: [
    DataCell(Text(data.data()['socio'])),
    DataCell(
      Text(data.data()['nombre']),
      onTap: () => getUser(data.data()['nombre']),
    ),
    DataCell(Text(data.data()['DNI'])),
  ]);
}

getUser(data) {
  String _named = data.toString();
  print(_named);
}




