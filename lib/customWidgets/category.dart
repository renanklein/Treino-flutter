import 'package:flutter/material.dart';
import 'package:hello_retangle/customWidgets/unit.dart';
import 'package:hello_retangle/customWidgets/ConverterScreen.dart';
class Category{

  final String rowName;
  final ColorSwatch backColor;
  final String iconPath;
  final List<Unit> units;
  const Category({
    @required this.rowName,
    @required this.backColor,
    @required this.iconPath,
    @required this.units
      }):assert(rowName != null),
        assert(backColor != null),
        assert(iconPath != null),
        assert(units != null);


}
