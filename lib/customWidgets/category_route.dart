import 'package:flutter/material.dart';
import 'package:hello_retangle/customWidgets/category.dart';
import 'package:hello_retangle/customWidgets/unit.dart';
import 'package:hello_retangle/customWidgets/ConverterScreen.dart';
import 'package:hello_retangle/customWidgets/backdrop.dart';
import 'package:hello_retangle/customWidgets/category_Tile.dart';
import 'package:hello_retangle/api.dart';

import "dart:async";
import 'dart:convert';
class _CategoryRouteState extends State<CategoryRoute>{
  Category _defaultCategory;
  Category _currentCategory;
  final _listCategories = <Category>[];

  @override
  Future<void> didChangeDependencies() async{
    super.didChangeDependencies();

    if(_listCategories.isEmpty){
       await _retriveLocalCategories();
       await _retrieveApiCategory();
    }
  }

  Future<void> _retriveLocalCategories() async{
    final json = DefaultAssetBundle.of(context).loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    print(data);
    var categoryIndex = 0;
    if(data is! Map){
      throw('Data retrived from the API is not a JSON !');
    }
    data.keys.forEach((key){
      final List<Unit> units = data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      var category = new Category(
          rowName: key,
          backColor: widget._baseColors[categoryIndex],
          iconPath: widget._iconPaths[categoryIndex],
          units: units
      );

      setState(() {
        if(categoryIndex == 0){
          print('Entrou');
          _defaultCategory = category;
        }

        _listCategories.add(category);
      });
      categoryIndex += 1;
    });
  }

  Future<void> _retrieveApiCategory() async{
    //Placeholder enquanto é carreega as unidades da currency
    setState(() {
      _listCategories.add(
        new Category(
          rowName: 'Currency',
          backColor: widget._baseColors.last,
          iconPath: 'assets/icons/currency.png',
          units:[],
        )
      );
    });

    final _currencyUnits = await Api().getUnits('currency');

    if(_currencyUnits != null){
      final units  = <Unit>[];

      for(var unit in _currencyUnits){
        units.add(Unit.fromJson(unit));
      }

      setState(() {
        _listCategories.removeLast();
        _listCategories.add(
          Category(
            rowName: 'Currency',
            backColor: widget._baseColors.last,
            iconPath: 'assets/icons/currency.png',
            units:units,
          )
        );
      });
    }
  }

  void _onCategoryTap(Category category){
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoriesWidget(Orientation deviceOrientation){
    if(deviceOrientation == Orientation.portrait){
      return ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          var _category = this._listCategories[i];
          return  Category_Tile(
              category: this._listCategories[i] ,
              onTap: _category.rowName == 'Currency' && _category.units.isEmpty ?
                  null : _onCategoryTap,
          );
        },
        itemCount: this._listCategories.length,
      );
    }else{
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _listCategories.map((Category c) {
          return Category_Tile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    assert(debugCheckHasMediaQuery(context));
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0
      ),
      child: _buildCategoriesWidget(MediaQuery.of(context).orientation),
    );

    return new Backdrop(
      currentCategory: this._currentCategory == null ? this._defaultCategory : this._currentCategory,
      frontPanel: this._currentCategory == null ?
        ConverterScreen(category: this._defaultCategory) : ConverterScreen(category: this._currentCategory),
      backPanel: listView,
      frontTitle: Text('Unit Conveter'),
      backTitle: Text('Select a category'),
    );
  }
}
class CategoryRoute extends StatefulWidget {



  final _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];
  
  final List<String> _iconPaths =[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png'
  ];


  @override
  createState() => _CategoryRouteState();
}