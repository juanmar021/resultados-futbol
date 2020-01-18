import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';


import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/providers/partidos_provider.dart';
import 'package:resultados_futbol/src/utils/Funciones.dart';




class MainBloc{

     final _ligasController    = new BehaviorSubject<List<LigaModel>>();
     final _partidosController = new BehaviorSubject<List<LigaModel>>();
     final _fechaPartidosController = new BehaviorSubject<String>();
    

     final _partidosProvider   = new PartidosProvider();


    Stream<List<LigaModel>> get ligasStream => _ligasController.stream;
    Stream<List<LigaModel>> get partidosStream => _partidosController.stream;

    Stream<String> get fechaPartidosStream => _fechaPartidosController.stream;

  MainBloc(){
    _fechaPartidosController.sink.add(DateFormat("yyyy-MM-dd").format( DateTime.now()));
  }


  void cargarLigas() async {

    // _ligasController.sink.add(null);
     final partidos = await _partidosProvider.getPartidos(_fechaPartidosController.value);

    final ligas=Funciones.fixtureOrderByLeague(partidos);

    _ligasController.sink.add( ligas);
     _partidosController.sink.add( ligas);

  }

 void setFechaPartidos(String fecha){
    _fechaPartidosController.sink.add(fecha);
 }
  
 
 void setPartidos(List<LigaModel> ligas){
    _partidosController.sink.add(ligas);
 }
  






   dispose() {
    _ligasController?.close();
    _partidosController?.close();
    _fechaPartidosController?.close();
  }







}