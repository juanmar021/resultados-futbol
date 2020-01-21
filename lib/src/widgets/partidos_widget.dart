


import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/widgets/load_image.dart';
 


class Partidos extends StatelessWidget {

  final TextStyle txtMarcador= TextStyle(fontWeight: FontWeight.bold,fontSize: 18);
  final TextStyle txtEquipos= TextStyle(fontSize: 17);

  final List<LigaModel> ligas;


  Partidos({ @required this.ligas});

 

  @override
  Widget build(BuildContext context) {

 
    return ListView.builder(

        itemCount: ligas.length,
        itemBuilder: (BuildContext context, int i){
          return Container(

           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),

            child: Column(
              children: <Widget>[
                
                _liga(context,ligas[i]),
                SizedBox(height: 20)

              ],
            ),
          );
        }
    );
    
    
  }
 

  

  Widget _liga(BuildContext context, LigaModel liga)
  {
    final size = MediaQuery.of(context).size;

    return Container(   
       
       
        child:Column(
          children: <Widget>[
          Row(
            children: <Widget>[
               LoadImage(
                      url: liga.getEscudo(),
                      height: 30,
                      width: 30,
              ),
              SizedBox(width: 10),
              Text('${ liga.country }:',style: Theme.of(context).textTheme.subtitle),
              SizedBox(width: 10),
              Text(liga.name,style: Theme.of(context).textTheme.caption),

            ],
          ),

          SizedBox(height: 15),
            _containerPartidos(liga.partidos,size,context)
          ],
        )
          
        
              
    );
  }
  Widget _containerPartidos(List<PartidoModel> partidos,Size size,BuildContext context)
  {
    return  Container(
      width: double.infinity,
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.5,
                  offset: Offset(0.0, 2.0),
                  spreadRadius: 0.5
                )
              ]
      ),
        child:Column(
          children:_partidos(partidos,size,context)
        )
      );
  }
   

  List<Widget> _partidos(List<PartidoModel> partidos,Size size,BuildContext context)
  {
    List <Widget> _partidosWidgets= new List();

    partidos.forEach((item){

      _partidosWidgets.add(_partido(item,size ,context));
    });

  
    return _partidosWidgets;
  }
  Widget _partido(PartidoModel partido,Size size,BuildContext context)
  {
    
     Widget marker=Text('-');
     if(partido.goalsAwayTeam==null)
     {
       marker=_horaPartido(partido.eventDate.substring(11,16));
     }else{
       if(partido.elapsed>0){
         if(partido.status=='Match Finished'){
            
           marker=_marcador(partido.goalsHomeTeam,partido.goalsAwayTeam,partido.statusShort);   

           }else{

             marker=_marcadorOnline(partido.goalsHomeTeam,partido.goalsAwayTeam,partido.elapsed);

           }
         }
       }

  
       return InkWell(
          onTap: (){Navigator.pushNamed(context, 'partidos/detalles',arguments: partido);},
          child: Container(           
           padding: EdgeInsets.symmetric(vertical: 8),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Flexible(
            
                  child: Container(
                    width: size.width*0.35,
                    child: Text(
                      partido.homeTeam.teamName,
                      textAlign: TextAlign.left,
                      style: txtEquipos,
                      overflow: TextOverflow.ellipsis
                      ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LoadImage(
                      url:  partido.homeTeam.getEscudo(),
                      height: 30,
                      width: 30,
                    ),
                    marker,               
                     LoadImage(
                      url:  partido.awayTeam.getEscudo(),
                      height: 30,
                      width: 30,
                    ),
                  ]
                  ),
                
                 Flexible(
                  child: Container(
                  width: size.width*0.35,

                     child: Text(                
                      partido.awayTeam.teamName,
                      style: txtEquipos,
                      textAlign: TextAlign.right,                  
                      overflow: TextOverflow.ellipsis
                      ),
                   ),
                 ),


            ],
            )
    ),
  );
  

  }

  Widget _horaPartido(String hora)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.watch_later,color: Colors.grey,),
          Text('$hora')
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
          Text("$minutos'",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.green)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(golLocal.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green)),
              Text(':',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.green)),
              Text(golVisitante.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green))
            ],
            ),
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
              Text(golLocal.toString(),style: txtMarcador),
              Text(':'),
              Text(golVisitante.toString(),style: txtMarcador)
            ],
            
            ),
            Text(status,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey))

        ],
      ),
    );
  }
}