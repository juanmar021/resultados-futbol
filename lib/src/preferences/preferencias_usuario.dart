
import 'dart:convert';

import 'package:resultados_futbol/src/models/equipo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de partidos favoritos


   List<EquipoModel> get equiposFavoritos{
    
     String jsonPreferences = _prefs.getString("equiposFavoritos"); 
     if(jsonPreferences!=null){

    var decode=json.decode(jsonPreferences);

    List<EquipoModel> equipos=Equipos.fromJsonList(decode).items;
    if(equipos==null)return [];
    else return equipos;
     }


     return [];
 
 
 
  }

  set equiposFavoritos(List<EquipoModel> equipos){
 
    _prefs.setString("equiposFavoritos", json.encode(equipos));

  }

  

}
