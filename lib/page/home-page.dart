import 'package:flutter/material.dart';
import 'dart:math';
import 'package:taller2/page/resultados.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String operaciones = "";
  List<Text> resultados = [];
  String mensaje = "";
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: resultados,
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(operaciones),
                  Text(mensaje),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.yellow,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "7";
                        });
                      },
                      child: Text("7")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "8";
                        });
                      },
                      child: Text("8")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "9";
                        });
                      },
                      child: Text("9")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += " / ";
                        });
                      },
                      child: Text("/")),
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "√";
                    });
                  },
                  child: Text("√")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "4";
                        });
                      },
                      child: Text("4")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "5";
                        });
                      },
                      child: Text("5")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "6";
                        });
                      },
                      child: Text("6")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += " x ";
                        });
                      },
                      child: Text("x")),
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "²";
                    });
                  },
                  child: Text("²")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "1";
                        });
                      },
                      child: Text("1")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "2";
                        });
                      },
                      child: Text("2")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "3";
                        });
                      },
                      child: Text("3")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += " - ";
                        });
                      },
                      child: Text("-")),
                      ElevatedButton(
                  onPressed: () {
                    setState(() {
                      operaciones += "%";
                    });
                  },
                  child: Text("%")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += "0";
                        });
                      },
                      child: Text("0")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones = "";
                          error = false;
                          mensaje = "";
                        });
                      },
                      child: Text("C")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {                          
                          double result = _calcular(operaciones);
                          if(error){                            
                            mensaje= "Operación no valida";
                            
                          }else{
                            resultados.add(Text("$operaciones = $result"));
                            operaciones = "$result";
                          }
                          
                        });
                      },
                      child: Text("=")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          operaciones += " + ";
                        });
                      },
                      child: Text("+")),
                  ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultadosPage(resultados: resultados)));                  
                  },
                  child: Text("R")),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  double _calcular(String operacion) {
    try{
      double result = 0;
      if (operacion.indexOf(" + ") != -1) {
        List<String> terminos = operacion.split(" + ");
        for (String valor in terminos) {
          result += _calcular(valor);
        }
      } else if (operacion.indexOf(" - ") != -1) {
        List<String> terminos = operacion.split(" - ");
        result += _calcular(terminos.elementAt(0));
        for (var i = 1; i < terminos.length; i++) {
          result -= _calcular(terminos.elementAt(i));
        }
      } else if (operacion.indexOf(" / ") != -1) {
        List<String> terminos = operacion.split(" / ");
        result += _calcular(terminos.elementAt(0));
        for (var i = 1; i < terminos.length; i++) {
          result = result / _calcular(terminos.elementAt(i));
        }
      } else if (operacion.indexOf(" x ") != -1) {
        result = 1;
        List<String> terminos = operacion.split(" x ");
        for (String valor in terminos) {
          result *= _calcular(valor);
        }
      } else if (operacion.indexOf("√") != -1) {
        List<String> terminos = operacion.split("√");
        result = sqrt(_calcular(terminos.elementAt(1)));
      } else if (operacion.indexOf("²") != -1) {
        List<String> terminos = operacion.split("²");
        result = _calcular(terminos.elementAt(0));
        result *= result;
      } else if (operacion.indexOf("%") != -1) {
        List<String> terminos = operacion.split("%");
        result = double.parse(terminos.elementAt(0));
        result /= 100;
      } else if(operacion == ""){
        throw Exception("Termino vacio");
      }else{
        result = double.parse(operacion);
      }
      return result;
    }catch(e){
      error = true;
      return 0;
    }
    
    
  }
  
}