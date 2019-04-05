import 'package:flutter/material.dart';
import 'package:hello_retangle/customWidgets/category.dart';
import 'package:hello_retangle/customWidgets/category_route.dart';

const _name = "Cake";
const _color = Color.fromARGB(80, 70, 90, 67);
const _icon = Icon(Icons.cake,size: 60,);

class UnitConverterApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exercício",
      home: new Scaffold(
        backgroundColor: Colors.green[100],
        body: new Center(
            child: CategoryRoute(),
        )
      )
    );
  }
}

void main(){
  runApp(UnitConverterApp());
}

