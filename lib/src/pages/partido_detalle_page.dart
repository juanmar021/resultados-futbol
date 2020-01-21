
import 'package:flutter/material.dart';

import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/equipo_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/preferences/preferencias_usuario.dart';
import 'package:resultados_futbol/src/services/api_response.dart';
import 'package:resultados_futbol/src/utils/Funciones.dart';
import 'package:resultados_futbol/src/widgets/detallePartido.dart';
import 'package:resultados_futbol/src/widgets/loading_widget.dart';
import 'package:resultados_futbol/src/widgets/error_widget.dart';


class PartidoDetallePage extends StatefulWidget {


  @override
  _PartidoDetallePageState createState() => _PartidoDetallePageState();
}

class _PartidoDetallePageState extends State<PartidoDetallePage>  with SingleTickerProviderStateMixin {

  PartidoModel _partido;
  // Size _screenSize;
  TextStyle _styleMarker =TextStyle(fontSize: 25,color: Colors.white);

  final prefs = new PreferenciasUsuario();

  List<EquipoModel> _equiposFavoritos;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PartidosBloc bloc;


  @override
  Widget build(BuildContext context) {

    _equiposFavoritos=prefs.equiposFavoritos;

   _partido = ModalRoute.of(context).settings.arguments;

    bloc = Provider.partidosBloc(context);
 
   bloc.cargarPartido(_partido.fixtureId);
 
    return   Scaffold(
        key: _scaffoldKey, 
        appBar:AppBar(
             title:Text(
                  '${_partido.league.name.toUpperCase()}: ${_partido.round.toUpperCase()}',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),
              ),
             elevation: 0
             ),

             body: Container(
               child: Column(
                 children: <Widget>[
                   _crearHeader(),
                   Expanded(
                     child: _cargarEventos(bloc)
                     )
             

               ],),
             ),
            //  body:_body()
        
        );
  }

 


  Widget _cargarEventos(PartidosBloc bloc)
  {
      return StreamBuilder(
        stream: bloc.partidoStream,
        builder: (BuildContext context, AsyncSnapshot<ApiResponse<PartidoModel>> snapshot){
      
       if(snapshot.hasData){
      
        switch (snapshot.data.status) {
          
                case Status.LOADING:
                  return Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Loading(mensaje: snapshot.data.message));
                  break;
                case Status.COMPLETED:
             
                 return DetallePartido(partido: snapshot.data.data,);
                  break;
                case Status.ERROR:
                  return Error(
                    reintentarAction: (){bloc.cargarPartido(_partido.fixtureId);},
                    mensaje:snapshot.data.message
                    );
                  
                  break;
        
        }
        }
        return Container();
        }
      );
  }

  
    Widget _crearHeader(){
    return SafeArea(
          child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          padding: EdgeInsets.only(bottom: 20,left: 10,right: 10),
          child:Center(
            child: Column(
         
              children: <Widget>[
             
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                       children:<Widget>[
                        GestureDetector(
                          onTap: (){_favorite(_partido.homeTeam);},
                          child: Icon(_isFavorite(_partido.homeTeam.teamId)?Icons.favorite:Icons.favorite_border,
                            color: Colors.white,
                          )
                          ),
                          SizedBox(width: 10,),
                        _escudo(_partido.homeTeam.getEscudo(),_partido.homeTeam.teamName)
                    ],
                    ),
                    _crearMarcador(),
                   
                    Row(
                      children:<Widget>[
                        _escudo(_partido.awayTeam.getEscudo(),_partido.awayTeam.teamName),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){_favorite(_partido.awayTeam);},
                          child: Icon(_isFavorite(_partido.awayTeam.teamId)?Icons.favorite:Icons.favorite_border,
                          color: Colors.white,)
                          ),
                    ],
                    ),
                  ],
                ),
                
              ],
            ),
          )
      ),
    );
  }


bool _isFavorite(int idEquipo){

  bool existe=false;
  
  _equiposFavoritos.forEach((e){if(e.teamId==idEquipo)existe=true;});


  return existe;


}

void _favorite(Equipo equipo){

  bool existe=_isFavorite(equipo.teamId);
  

  if(existe){
    //eliminar
    _equiposFavoritos.removeWhere((e)=>equipo.teamId==e.teamId);
    _displaySnackBar('Equipo eliminado de favoritos');

  }else{
    //agergar
    _equiposFavoritos.add(EquipoModel.fromJson(equipo.toJson()));
    _displaySnackBar('Equipo agregado de favoritos');


  }
  
  setState(() {

  bloc.setEquiposFavoritos(_equiposFavoritos);
  // prefs.equiposFavoritos=_equiposFavoritos;
    
  });

}


 _displaySnackBar(String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje),duration: Duration(milliseconds: 800),);
    _scaffoldKey.currentState.showSnackBar(snackBar);   
}

Widget _escudo(String url,String equipo){

  return   Column(
      children: <Widget>[
        FadeInImage(
                            image: NetworkImage(url),
                            placeholder:AssetImage('assets/loader.gif') ,
                            height: 50,
          ),
         
        SizedBox(height: 5,),
        Container(
          
          child: Text(
            equipo,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10,color: Colors.white),
            overflow: TextOverflow.ellipsis
            ),
        ),
               

      ],
    );
 
}
Widget _crearMarcador(){

      Widget marker=Text('-');
     if(_partido.goalsAwayTeam==null)
     {
       marker=_horaPartido();
     }else{
       if(_partido.elapsed>0){
         if(_partido.status=='Match Finished'){
            
           marker=_marcador(_partido.goalsHomeTeam,_partido.goalsAwayTeam,_partido.statusShort);   

           }else{

             marker=_marcadorOnline(_partido.goalsHomeTeam,_partido.goalsAwayTeam,_partido.elapsed);

           }
         }
       }
  return marker;
}
Widget _horaPartido()
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.restore,color: Colors.white,size: 50,),
          Text(Funciones.formatDate(_partido.eventDate),style: TextStyle(color: Colors.white),),
          Text(_partido.eventDate.substring(11,16),style: TextStyle(color: Colors.white),)
        ],
      )
    );
  }

  Widget _marcadorOnline(int golLocal,int golVisitante,int minutos)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: <Widget>[
          Text("$minutos'",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(golLocal.toString(),style: _styleMarker),
              Text(':',style:_styleMarker),
              Text(golVisitante.toString(),style: _styleMarker)
            ],
            ),
        SizedBox(height: 10),
       Text("${_partido.status}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white)),

        ],
      ),
    );
  }

  Widget _marcador(int golLocal,int golVisitante,String status)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(golLocal.toString(),style:_styleMarker),
              Text(':',style:_styleMarker),
              Text(golVisitante.toString(),style: _styleMarker)
            ],
            
            ),
            Text(status,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white))

        ],
      ),
    );
  }
}