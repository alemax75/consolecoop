import 'package:coopscmconsole/model/consumo.dart';
import 'package:coopscmconsole/service/serviceconsumo.dart';
import 'package:flutter/material.dart';

Future<T> showTextDialog<T>(
  BuildContext context, {
  String title,
  String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  final textcolor = TextStyle(color: Colors.white);

  final nmedidor = TextEditingController();
  final lecturaant = TextEditingController();
  final lecturaact = TextEditingController();
  final estado = TextEditingController();
  final totalpesos = TextEditingController();
  final periodos = TextEditingController();
  final vencimiento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cloudService = FirestoreConsumo();
    saveConsumo() {
      var kw = int.parse(lecturaact.text) - int.parse(lecturaant.text);
      var nuevoconsumo = Consumo(
        userid: widget.value,
        lecturaactual: lecturaact.text,
        lecturaanterior: lecturaant.text,
        periodo: periodos.text,
        totalpesos: totalpesos.text,
        kilowats: kw.toString(),
        estado: estado.text,
        nmedidor: nmedidor.text,
        vence : vencimiento.text,
      );

      cloudService.saveConsumo(nuevoconsumo);
    }

    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        padding: EdgeInsets.all(20),
        width: 200,
        height: 400,
        color: Colors.green[900],
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: nmedidor,
                readOnly: false,
                style: textcolor,
                decoration: InputDecoration(
                  labelText: 'NºMedidor',
                ),
              ),
              TextFormField(
                controller: periodos,
                style: textcolor,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Periodo '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar periodo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lecturaant,
                style: textcolor,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Lectura Anterior'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lecturaact,
                style: textcolor,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Lectura Actual'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar valor';
                  }
                  return null;
                },
              ),
               TextFormField(
                controller: vencimiento,
                style: textcolor,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Vencimirnto de la factura'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar fecha';
                  }
                  return null;
                },
              ),




              TextFormField(
                controller: estado,
                style: textcolor,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Ingresar estado de pago'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar datos';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: totalpesos,
                keyboardType: TextInputType.number,
                style: textcolor,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Total valor en pesos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor ingresar valor';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Procesando')));

              Navigator.of(context).pop();
              saveConsumo();
            }
            return null;
          },
        )
      ],
    );
  }
}
