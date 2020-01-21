

import 'dart:async';


import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/services/api_base_helper.dart';
import 'package:resultados_futbol/src/utils/Funciones.dart';
  
class PartidosProvider{


    ApiBaseHelper _helper = ApiBaseHelper();

    Future<PartidoModel> getPartido(int idPartido) async {

 
    final response = await _helper.get('/v2/fixtures/id/$idPartido');

    final api=response['api'];
 
    final PartidoModel partido = PartidoModel.fromJson(api['fixtures'][0]);

    return partido;


  }

    Future<List<LigaModel>> getPartidosOnline() async {

 

    final response = await _helper.get('/v2/fixtures/live?timezone=America/Bogota');

    final api=response['api'];
 
     final List<PartidoModel> partidos = Partidos.fromJsonList(api['fixtures']).items;

    return Funciones.fixtureOrderByLeague(partidos);


  }

}