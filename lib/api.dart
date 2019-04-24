import 'dart:async';
import 'dart:convert' show json,utf8;
import 'dart:io';

import 'package:hello_retangle/customWidgets/unit.dart';
class Api {
  final http = HttpClient();
  final url = 'flutter.udacity.com';


   Future<List> getUnits(String category) async{
     try{
       final uri = Uri.https(url,'/$category');
       final request = await http.getUrl(uri);
       final response = await request.close();

       if(response.statusCode !=  HttpStatus.ok){
         return null;

       }
       final responseBody = await response.transform(utf8.decoder).join();
       final jsonResponse = json.decode(responseBody);

       return jsonResponse['units'];
     }on Exception catch(e){
       print('$e');
       return  null;
     }

   }
    Future<double> convert(String category,String amount, String fromUnit, String toUnit) async {
    try{
      final uri = Uri.https(url, '/$category/convert',
          {'amount':amount,'from':fromUnit, 'to':toUnit});

      final httpRequest = await http.getUrl(uri);
      final httpResponse = await httpRequest.close();

      if(httpResponse.statusCode !=  HttpStatus.ok){
        return null;
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final jsonResponse = json.decode(responseBody);
      return jsonResponse['conversion'].toDouble();
    }on Exception catch(e){
      print('$e');
      return null;
    }
   }
}
