import 'package:flutter/material.dart';


class Category extends StatelessWidget{

  String rowName;
  Color backColor;
  Icon leftIcon;
  Category(String name, Color color, Icon icon){
    this.rowName = name;
    this.backColor = color;
    this.leftIcon = icon;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: Colors.green[100],
      child: new Container(
        height: 100.00,
        padding: EdgeInsets.all(8.0),
        child: new InkWell(
          highlightColor: this.backColor,
          borderRadius: BorderRadius.all(Radius.circular(50.00)),
          onTap:() {
            print("I was tapped");
          },
          child: new Padding(
            padding: EdgeInsets.all(16.00),
            child:  new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children : <Widget>[
                new Padding(
                    padding: EdgeInsets.only(right: 16.00),
                  child:  this.leftIcon
                ),
                new Center(
                  child: new Text(
                    this.rowName,
                    style: TextStyle(fontSize: 24.00,fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
