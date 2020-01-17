

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';



import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/utils/constantes.dart';

class PartidosProvider{



    Future<List<PartidoModel>> getPartidos(String fecha) async {

   
    final url = Uri.https(Constantes.URL, '/v2/fixtures/date/$fecha',
    {
      "timezone": "America/Bogota"
    });

    Map <String,String> headers={
      "Content-type": "application/json", 
      "Accept": "application/json",
      "x-rapidapi-host": Constantes.URL,
		  "x-rapidapi-key": Constantes.API_KEY
    };

    final resp = await http.get(url,headers: headers);
    final decodedData = json.decode( resp.body );

   final api=decodedData['api'];
 
    final partidos = Partidos.fromJsonList(api['fixtures']);
 
    return partidos.items;

  }

}