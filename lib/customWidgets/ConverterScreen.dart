import 'package:hello_retangle/customWidgets/unit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:hello_retangle/customWidgets/category.dart';
import 'package:hello_retangle/api.dart';

class _ConverterScreenState extends State<ConverterScreen> {

  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _valueConverted = '';
  List<DropdownMenuItem> _userDropdownItems;
  bool _errorValidation = false;
  bool _showErrorUI = false;

  final _inputKey = GlobalKey(debugLabel: 'inputText');

  @override
  void initState(){
    super.initState();
    _createDropdownItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(ConverterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.category != widget.category){
      _createDropdownItems();
      _setDefaults();
    }
  }
  void _createDropdownItems(){
    var newItems = <DropdownMenuItem>[];

    for(var unit in widget.category.units){
      newItems.add(
        new DropdownMenuItem(
          value:unit.name,
          //O que vai ser exibido no dropdown ...
          child:Container(
            child:Text(
              unit.name,
              softWrap: true,
            )
          )
        )
      );
      setState(() {
        _userDropdownItems = newItems;
      });
    }
  }

  void _setDefaults(){
    setState(() {
      _fromValue = widget.category.units[0];
      _toValue = widget.category.units[1];
    });
  }


  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  Future<void> _updateConvertion() async{
    if(widget.category.rowName == 'Currency'){
      final convert =  await Api().convert('currency', this._inputValue.toString(),this._fromValue.name , this._toValue.name);
      if(convert == null){
        setState(() {
          this._showErrorUI = true;
        });
      }
      setState(() {
        this._valueConverted = _format(convert);
      });
    }else{
      this._valueConverted = _format( _inputValue * (_toValue.convert / _fromValue.convert));
    }
  }

  void _updateInputValue(String input){
    setState(() {
      if(input == null || input.isEmpty){
        _valueConverted = '';
      }else{
        try{
          final doubleInput = double.parse(input);
          _errorValidation = false;
          _inputValue = doubleInput;
          _updateConvertion();
        } on Exception catch(e){
          print('Error: $e');
          _errorValidation = true;
        }
      }
    });
  }

  Unit _getUnit(String unitName){
    return widget.category.units.firstWhere(
        (Unit unit){
          return unit.name == unitName;
        },
      orElse: null,
    );
  }

  void _updateFromConvertion(dynamic unitName){
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if(_inputValue != null){
      _updateConvertion();
    }
  }

  void _updateToConvertion(dynamic unitName){
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if(_inputValue != null){
      _updateConvertion();
    }
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChange){
    return new Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0
        )
      ),
      padding:EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child:ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _userDropdownItems,
              onChanged: onChange,
              style: Theme.of(context).textTheme.title,
            )
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    if(widget.category.units == null || (widget.category.rowName == 'Currency' && this._showErrorUI)){
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: widget.category.backColor['error'],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning,
                size: 180.0,
                color: Colors.white,
              ),
              Text(
                'An connection error occured!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.white,
                )
              ),
            ],
          ),
        ),
      );
    }

    final input = Padding(
      padding: EdgeInsets.all(16.0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            key: _inputKey,
            style:Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.display1,
              errorText: _errorValidation ? 'Entrada inválida' : null,
              labelText: 'Input',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              )
            ),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConvertion)
        ],
      )
    );
    final icon = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final output = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            child:Text(
              _valueConverted,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.display1,
              labelText: 'Output',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              )
            ),
          ),
          _createDropdown(_toValue.name,_updateToConvertion),
        ],
      )
    );

    final converter = ListView(
      children: <Widget>[
      input,
      icon,
      output,
      ],
    );

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: OrientationBuilder(
          builder: (BuildContext context,Orientation o){
            if(o == Orientation.portrait){
              return converter;
            }else{
              return  Center(
                child: Container(
                  width: 450,
                  child: converter ,
                ),
              );
            }
          }
      ),
    );
  }
}

class ConverterScreen extends StatefulWidget {

  final Category category;
  const ConverterScreen({
    @required this.category,
  }):assert(category != null);


  @override
  createState() => _ConverterScreenState();
}
