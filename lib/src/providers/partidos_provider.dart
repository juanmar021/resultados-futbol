

import 'dart:async';


import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/services/api_base_helper.dart';
  
class PartidosProvider{


    ApiBaseHelper _helper = ApiBaseHelper();

    Future<PartidoModel> getPartido(int idPartido) async {

 
    final response = await _helper.get('/v2/fixtures/id/$idPartido');

    final api=response['api'];
 
    final PartidoModel partido = PartidoModel.fromJson(api['fixtures'][0]);

    return partido;


  }

}