

import 'dart:convert';

import 'package:resultados_futbol/src/services/app_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class ApiBaseHelper {
  
     final String _baseUrl="https://api-football-v1.p.rapidapi.com";
     final String _host="api-football-v1.p.rapidapi.com";
     final String _apiKey= "11e8e7c25cmshecd29a7e0153944p181f48jsn28a5aa6f5635";

     Map <String,String> headers;

    ApiBaseHelper(){
 
     this.headers={
      "Content-type": "application/json", 
      "Accept": "application/json",
      "x-rapidapi-host": _host,
		  "x-rapidapi-key":_apiKey
    };
    }

    
  
Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url,headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('Revise su conexión a internet');
    }
    return responseJson;
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
  
}
}