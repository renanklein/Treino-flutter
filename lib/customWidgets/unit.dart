import 'package:meta/meta.dart';

class Unit{
  final String name;
  final double convert;

  const Unit({
    @required this.name,
    @required this.convert
  }):assert(name != null),
     assert(convert != null);


  Unit.fromJson(Map jsonMap)
    :assert(jsonMap['name'] != null),
     assert(jsonMap['conversion'] != null),
    name = jsonMap['name'],
    convert = jsonMap['conversion'].toDouble();
}
