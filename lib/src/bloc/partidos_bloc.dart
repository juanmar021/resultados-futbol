
import 'dart:async';


import 'package:resultados_futbol/src/models/equipo_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/preferences/preferencias_usuario.dart';
import 'package:resultados_futbol/src/providers/partidos_provider.dart';
import 'package:resultados_futbol/src/services/api_response.dart';
import 'package:rxdart/subjects.dart';


import 'package:resultados_futbol/src/models/liga_model.dart';




class PartidosBloc{

    PartidosProvider _partidosProvider = new PartidosProvider();
    PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();

    final  _partidosController    = BehaviorSubject<List<LigaModel>>(); 
    final  _partidoController    = BehaviorSubject<ApiResponse<PartidoModel>>(); 
    final  _equiposFavoritosController    = BehaviorSubject<List<EquipoModel>>(); 
    final  _partidosEnvivoController    = BehaviorSubject<ApiResponse<List<LigaModel>>>(); 



    Stream<ApiResponse<List<LigaModel>>>     get partidosEnvivoStream => _partidosEnvivoController.stream;
    StreamSink<ApiResponse<List<LigaModel>>> get partidosEnvivoSink=> _partidosEnvivoController.sink;

    Stream<List<LigaModel>>     get partidosStream => _partidosController.stream;
    StreamSink<List<LigaModel>> get partidosSink=> _partidosController.sink;

    Stream<ApiResponse<PartidoModel>>     get partidoStream => _partidoController.stream;
    StreamSink<ApiResponse<PartidoModel>> get partidoSink=> _partidoController.sink;

    Stream<List<EquipoModel>>     get equiposFavoritosStream => _equiposFavoritosController.stream;
    StreamSink<List<EquipoModel>> get equiposFavoritosSink=> _equiposFavoritosController.sink;



 PartidosBloc(){
   cargarEquiposFavoritos();
   cargarPartidosEnvivo();
 }


 

  void cargarPartido(int idPartido) async {

     partidoSink.add(ApiResponse.loading('Cargando más info...'));

    try {
      PartidoModel partido = await _partidosProvider.getPartido(idPartido);
      partidoSink.add(ApiResponse.completed(partido));
    } catch (e) {
      partidoSink.add(ApiResponse.error(e.toString()));
      print(e);
    }

  }

    void cargarPartidosEnvivo() async {

     partidosEnvivoSink.add(ApiResponse.loading('Cargando partidos...'));

    try {
      List<LigaModel> partidos = await _partidosProvider.getPartidosOnline();
      partidosEnvivoSink.add(ApiResponse.completed(partidos));
    } catch (e) {
      partidosEnvivoSink.add(ApiResponse.error(e.toString()));
      print('Error en cargar partidos: '+e.toString());
    }

  }


void cargarEquiposFavoritos()
{
  equiposFavoritosSink.add(_preferenciasUsuario.equiposFavoritos);
}

 
 void setPartidos(List<LigaModel> partidos){
    _partidosController.sink.add(partidos);
 }


  void setEquiposFavoritos(List<EquipoModel> equipos){
    _preferenciasUsuario.equiposFavoritos=equipos;
    _equiposFavoritosController.sink.add(equipos);
 }
  


   dispose() {
    _partidosController?.close();
    _partidoController?.close();
    _equiposFavoritosController?.close();
    _partidosEnvivoController?.close();
  }


}