import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Calculadora Científica",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(height: 40.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (_username == 'admin' && _password == 'admin') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyAppWithCalculator()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Credenciais Inválidas!'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppWithCalculator extends StatefulWidget {
  @override
  _MyAppWithCalculatorState createState() => _MyAppWithCalculatorState();
}

class _MyAppWithCalculatorState extends State<MyAppWithCalculator> {
  bool isDarkTheme = true;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheme
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark().copyWith(
                primary: Colors.blueAccent,
                secondary: Colors.blueAccent,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: Colors.blueAccent,
                secondary: Colors.blueAccent,
              ),
            ),
      home: CalculatorHome(toggleTheme: toggleTheme, isDarkTheme: isDarkTheme),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkTheme;

  CalculatorHome({required this.toggleTheme, required this.isDarkTheme});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome>
    with SingleTickerProviderStateMixin {
  String _output = "0";
  String _input = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _input = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        _output = "0";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "*" ||
          buttonText == "√" ||
          buttonText == "^") {
        _num1 = double.parse(_input);
        _operand = buttonText;
        _input = "";
      } else if (buttonText == ".") {
        if (_input.contains(".")) {
          return;
        } else {
          _input = _input + buttonText;
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_input);

        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "*":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = (_num1 / _num2).toString();
            break;
          case "√":
            _output = math.sqrt(_num1).toString();
            break;
          case "^":
            _output = math.pow(_num1, _num2).toString();
            break;
          default:
            _output = _num1.toString();
            break;
        }

        _input = _output;
        _operand = "";
      } else {
        _input = _input + buttonText;
      }

      _output = _input;
    });
  }

  Widget buildButton(String buttonText, {Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => buttonPressed(buttonText),
          borderRadius: BorderRadius.circular(12.0),
          splashColor: widget.isDarkTheme ? Colors.white24 : Colors.black26,
          child: Ink(
            decoration: BoxDecoration(
              color:
                  widget.isDarkTheme ? Colors.blueGrey[900] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora Científica"),
        actions: [
          Switch(
            value: widget.isDarkTheme,
            onChanged: (value) {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/", textColor: Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*", textColor: Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", textColor: Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("C", textColor: Colors.redAccent),
                  buildButton("0"),
                  buildButton("."),
                  buildButton("+", textColor: Colors.blueAccent),
                ],
              ),
              Row(
                children: [
                  buildButton("√", textColor: Colors.blueAccent),
                  buildButton("^", textColor: Colors.blueAccent),
                  buildButton("=",
                      textColor:
                          widget.isDarkTheme ? Colors.white : Colors.black),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
