import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  )); //MaterialApp
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  //Variaveis:
  String infoText = 'Informe seus dados';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //Funções:
  //Função para construir os dois campos de texto:
  Widget buildTextField(String label, TextEditingController c){
    return TextField(
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.green, fontSize: 25.0),
      keyboardType: TextInputType.number,
      controller: c,
    );
  }

  void _calculate(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    double imc = weight / (height * height);

    setState(() { //Para informar que houve mudança e refazer o app
      if(imc < 18.49){
        infoText = "Abaixo do peso $imc";
      }else if( imc > 18.49 && imc <= 25){
        infoText = "Peso normal $imc";
      }else if(imc > 25){
        infoText = 'Acima do peso $imc';
      }
    });

  }

  void resetFields(){
    setState(() {
      weightController.text = '';
      heightController.text = '';
      infoText = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Calculadora IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
            onPressed: (){
              resetFields();
            },)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 170.0, color: Colors.green,),
              buildTextField("Peso", weightController),
              Divider(),
              buildTextField("Altura", heightController),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(onPressed: (){
                    _calculate();
                  },
                    child: Text("Verificar", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(infoText, style: TextStyle(color: Colors.green, fontSize: 25.0),
                  textAlign: TextAlign.center,),
              )
            ],
          ),
        )
      );
  }
}
