import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _mass = 0;
  double _height = 0;
  double _imc = 0;
  String _classification = "";

  void _calculateImc() {
    setState(() {
      if (_mass > 0 && _height > 0) {
        _imc = _mass / pow(_height, 2);
        _checkClassification(_imc);
      } else {
        _imc = 0;
      }
    });
  }

  void _checkClassification(double value) {
    if (value < 18.5) {
      _classification = "Abaixo do peso";
    } else if ((value >= 18.5) && (value < 25)) {
      _classification = "Eutrófico (Peso ideal)";
    } else if ((value >= 25) && (value < 30)) {
      _classification = "Sobrepeso";
    } else if ((value >= 30) && (value < 35)) {
      _classification = "Obesidade grau I";
    } else if ((value >= 35) && (value < 40)) {
      _classification = "Obesidade grau II";
    } else {
      _classification = "Obesidade grau III";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Digite sua massa:', style: TextStyle(fontSize: 18)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: TextField(
                cursorColor: Colors.orange,
                onChanged: (value) {
                  String massString = value.replaceAll(",", "");
                  _mass = double.tryParse(massString) ?? 0;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "56.4",
                    hintStyle: TextStyle(color: Colors.black26)),
                keyboardType: TextInputType.number,
              ),
            ),
            const Text('Digite sua altura:', style: TextStyle(fontSize: 18)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              child: TextField(
                cursorColor: Colors.orange,
                onChanged: (value) {
                  String heightString = value.replaceAll(",", "");
                  _height = double.tryParse(heightString) ?? 0;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "1.72",
                    hintStyle: TextStyle(color: Colors.black26)),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextButton.icon(
                onPressed: _calculateImc,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                ),
                label: const Text(
                  "Calcular IMC",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.calculate, color: Colors.white),
              ),
            ),
            Container(
              child: _imc > 0
                  ? Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                            child: Text(_classification,
                                style: const TextStyle(fontSize: 26))),
                        Text(_imc.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 24)),
                      ],
                    )
                  : null,
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _calculateImc,
      //   tooltip: 'Calculate',
      //   child: const Icon(Icons.calculate),
      // ),
    );
  }
}
