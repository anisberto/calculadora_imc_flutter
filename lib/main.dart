import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weighController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _textInfo = "Informe Seus Dados!";
  GlobalKey<FormState> formKey;
  void _resetFields() {
    setState(() {
      weighController.text = "";
      heightController.text = "";
      formKey = GlobalKey<FormState>();
      _textInfo = "Informe Seus Dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weighController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weigth / (height * height);
      if (imc < 18.6) {
        _textInfo =
            "Seu IMC é: (${imc.toStringAsPrecision(4)})! Você esta abaixo do peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal! IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo =
            "Levemete acimda do peso! IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Obesidade Grau I! IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Obesidade Grau II! IMC: (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _textInfo = "Obesidade Grau III! IMC: (${imc.toStringAsPrecision(4)})";
      } else {
        _textInfo = "Erro no 10122"; // Erro de programação 10122
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 220.00,
                    color: Colors.white,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 30.0)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: weighController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 30.0)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha sua Altura!";
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        ),
                      )),
                  Text(
                    _textInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
