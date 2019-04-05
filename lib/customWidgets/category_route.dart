import 'package:flutter/material.dart';
import 'package:hello_retangle/customWidgets/category.dart';

class CategoryRoute extends StatelessWidget{

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    final _listCategories = <Category>[
      Category(_categoryNames[0],_baseColors[0],Icon(Icons.cake)),
      Category(_categoryNames[1],_baseColors[1],Icon(Icons.cake)),
      Category(_categoryNames[2],_baseColors[2],Icon(Icons.cake)),
      Category(_categoryNames[3],_baseColors[3],Icon(Icons.cake)),
      Category(_categoryNames[4],_baseColors[4],Icon(Icons.cake)),
      Category(_categoryNames[5],_baseColors[5],Icon(Icons.cake)),
      Category(_categoryNames[6],_baseColors[6],Icon(Icons.cake)),
      Category(_categoryNames[7],_baseColors[7],Icon(Icons.cake)),
    ];
     final listView = ListView.builder(
       itemBuilder: (BuildContext context, int index) =>  _listCategories[index],
       itemCount:_listCategories.length ,
     );

     final appbar = new AppBar(
       title: Center(
         child: Text("Unit Converter",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w300,color: Colors.black)),
       ),
       backgroundColor: Colors.green[100],

     );

     return new Scaffold(
       appBar: appbar,
       body: listView
     );
  }
}