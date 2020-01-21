

import 'dart:async';



import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/services/api_base_helper.dart';
import 'package:resultados_futbol/src/utils/Funciones.dart';
 
class LigasProvider{


    ApiBaseHelper _helper = ApiBaseHelper();

    Future<List<LigaModel>> getLigas(String fecha) async {

 

    final response = await _helper.get('/v2/fixtures/date/$fecha?timezone=America/Bogota');

    final api=response['api'];
 
    final List<PartidoModel> partidos = Partidos.fromJsonList(api['fixtures']).items;

    return Funciones.fixtureOrderByLeague(partidos);


  }

}