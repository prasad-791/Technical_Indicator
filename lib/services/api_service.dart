
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technical_indicator/models/time_instance.dart';

class ApiService{

  final String _url = "https://api.bottomstreet.com/forex/technical?forex_name=USDINR";

  Future<List<TimeInstance>> getData()async{

    final response = await http.get(
      Uri.parse(_url),
      headers: <String,String>{
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(response.body);
      // TimeInstance timeInstance = TimeInstance.fromJson('15min', json['15min']);

      List<TimeInstance> temp = [];
      json.forEach((key, value) {
        String timeInstance = '';
        if(key.toString().compareTo('weekly')==0){
          timeInstance += '1 WK';
        }else if(key.toString().compareTo('daily')==0){
          timeInstance += '1 DAY';
        }else if(key.toString().compareTo('monthly')==0){
          timeInstance += '1 MON';
        }else if(key.toString().contains('min')){
          timeInstance = key.toString().replaceFirst('min', ' MIN');
        }else if(key.toString().contains('hour')){
          timeInstance = key.toString().replaceFirst('hour', ' HR');
        }

        if(key.toString().compareTo('technical_indicator_of')!=0){
            temp.add(TimeInstance.fromJson(timeInstance, json[key.toString()]));
        }
      });

      // return {json['technical_indicator_of'].toString():temp};
      return temp;
    }else{
      print(response.body);
      throw Exception("Could get data. Try again later!!");
    }

  }
  

}
