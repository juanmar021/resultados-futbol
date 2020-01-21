
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';



class EventosPartido extends StatelessWidget {
 
   final List<Evento> eventos;
   final int idEquipoLocal;

   EventosPartido({@required this.eventos,@required this.idEquipoLocal});


  @override
  Widget build(BuildContext context) {
     return  SingleChildScrollView(
      child: Container(
         child:  Column(
        children: _eventos()
      ),
        ),
    );
 
  }

List<Widget> _eventos(){

  List<Widget> listEventos= new List();

  listEventos.add(_tiempo('1ER Tiempo'));

  bool tiempoAgregado=false;
  eventos.forEach((evento){
    if(evento.elapsed>45&&!tiempoAgregado) 
    { 
      listEventos.add(_tiempo('2DO Tiempo'));
      tiempoAgregado=true;
    }

    listEventos.add(evento.teamId==idEquipoLocal? _eventoLocal(evento):_eventoVisitante(evento));

      }
    );
 
  return listEventos;
}

Widget _eventoLocal(Evento evento){

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
         Container(
        child: Text(
          "${evento.elapsed}'",textAlign: TextAlign.left,style: TextStyle(color: Colors.grey[400]),),
         width: 30,),
         SizedBox(width: 10),
         Center(child: _icon(evento.type,evento.detail)),
         SizedBox(width: 15),
         Text('${evento.player}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
         SizedBox(width: 10,),
         _asistente(evento.assist,TextAlign.left)

      ],
    ),

  );


}

Widget _eventoVisitante(Evento evento){

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
         _asistente(evento.assist,TextAlign.right),
         SizedBox(width: 10,),
         Text('${evento.player}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
         SizedBox(width: 15),
         Center(child: _icon(evento.type,evento.detail)),
         SizedBox(width: 10),
         Container(
         child: Text(
          "${evento.elapsed}'",textAlign: TextAlign.right,style: TextStyle(color: Colors.grey[400]),),
         width: 30,),

      ],
    ),

  );


}



Widget _icon(String tipo,String detail){

 double size=20.0;
  switch(tipo)
  {
    case 'Goal': return  Icon(FontAwesomeIcons.futbol,size: size);
    case 'subst': return  Icon(Icons.cached,size: size);
    case 'Card' :  return _card(detail);


    default: return Icon(Icons.info_outline,size: size);
  }
}
Widget _card(String color){
  
  return Container(
    padding: EdgeInsets.only(left: 2),
    child: Container(
       decoration: BoxDecoration(
        color:color=='Yellow Card'?Colors.yellow:Colors.red,
        borderRadius: BorderRadius.circular(2)
      ),
      width: 12.0,
      height: 20.0,
    ),
  );
}

Widget _tiempo(String tiempo){
  return Container(
    height: 20,
    padding: EdgeInsets.only(left: 10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[300]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(tiempo,style:TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 12)),
      ],
    ),
  );
}
Widget _asistente(String _asistente,TextAlign textAlign){

Widget asistente=Container();
if(asistente!=null)
asistente= Expanded(
  child: Text(  
    '($_asistente)',  
    textAlign: textAlign,
    style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold,fontSize: 12),  
    overflow: TextOverflow.ellipsis,),
);

return asistente;
}
}