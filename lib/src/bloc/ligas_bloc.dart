import 'dart:async';

import 'package:intl/intl.dart';
import 'package:resultados_futbol/src/providers/ligas_provider.dart';
import 'package:resultados_futbol/src/services/api_response.dart';
import 'package:rxdart/subjects.dart';


import 'package:resultados_futbol/src/models/liga_model.dart';




class LigasBloc{

     final _ligasProvider   = new LigasProvider();


      final _fechaConsultasController = BehaviorSubject<String>();
      final  _ligasController         = BehaviorSubject<ApiResponse<List<LigaModel>>>(); 
    

    Stream<ApiResponse<List<LigaModel>>>     get ligasStream => _ligasController.stream;
    StreamSink<ApiResponse<List<LigaModel>>> get ligasSink=> _ligasController.sink;


    Stream<String> get fechaConsultasStream => _fechaConsultasController.stream;
    StreamSink<String> get fechaConsultasSink=> _fechaConsultasController.sink;


  LigasBloc(){
  
    _fechaConsultasController.sink.add(DateFormat("yyyy-MM-dd").format( DateTime.now()));

    cargarLigas();

  }


  void cargarLigas() async {

     ligasSink.add(ApiResponse.loading('Cargando ligas...'));

    try {
      List<LigaModel> ligas = await _ligasProvider.getLigas(_fechaConsultasController.value);
      ligasSink.add(ApiResponse.completed(ligas));
    } catch (e) {
      ligasSink.add(ApiResponse.error(e.toString()));
      print('Error en cargar ligas: '+e.toString());
    }

  }

 void setFechaPartidos(String fecha){
    _fechaConsultasController.sink.add(fecha);
 }
  
 dispose() {
    _ligasController?.close();
    _fechaConsultasController?.close();
  }







}