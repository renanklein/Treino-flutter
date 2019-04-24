import 'package:hello_retangle/customWidgets/category.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';


class Category_Tile extends StatelessWidget{
  final Category category;
  final ValueChanged<Category> onTap;

  const Category_Tile({
    @required this.category,
    @required this.onTap,
  }):assert(category != null);

//  void _navigateToConverter(BuildContext context){
//    if(Navigator.of(context).canPop()){
//      Navigator.of(context).pop();
//    }
//    Navigator.of(context).push(MaterialPageRoute<Null>(
//        builder: (BuildContext context){
//          return Scaffold(
//            appBar: AppBar(
//              elevation: 1.0,
//              title: Text(
//                category.rowName,
//                style: Theme.of(context).textTheme.display1,
//              ),
//              centerTitle: true,
//              backgroundColor: category.backColor,
//            ),
//            body: ConverterScreen(
//              category: category,
//            ),
//            resizeToAvoidBottomPadding: false,
//          );
//        }
//    ));
//
//  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: onTap == null ? Color.fromRGBO(50, 50, 50, 0.2) : Colors.transparent,
      child: new Container(
        height: 100.00,
        padding: EdgeInsets.all(8.0),
        child: new InkWell(
            highlightColor: this.category.backColor['highlight'],
            splashColor: this.category.backColor['splash'],
            borderRadius: BorderRadius.all(Radius.circular(50.00)),
            onTap: onTap == null ? null : () => onTap(category),
            child: new Padding(
              padding: EdgeInsets.all(16.00),
              child:  new Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children : <Widget>[
                  new Padding(
                      padding: EdgeInsets.only(right: 16.00),
                      child:  Image.asset(category.iconPath),
                  ),
                  new Center(
                    child: new Text(
                      this.category.rowName,
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