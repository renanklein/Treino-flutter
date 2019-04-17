import 'package:flutter/material.dart';
import 'package:hello_retangle/customWidgets/unit.dart';
import 'package:hello_retangle/customWidgets/ConverterScreen.dart';
class Category{

  final String rowName;
  final ColorSwatch backColor;
  final Icon leftIcon;
  final List<Unit> units;
  const Category({
    @required this.rowName,
    @required this.backColor,
    @required this.leftIcon,
    @required this.units
      }):assert(rowName != null),
        assert(backColor != null),
        assert(leftIcon != null),
        assert(units != null);


}
