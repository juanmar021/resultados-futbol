import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';


 class AlineacionPartidos extends StatelessWidget {

   final Lineups alineaciones;
   final TextStyle _styleTextPlayer= TextStyle(fontSize: 13);
   AlineacionPartidos({@required this.alineaciones});
  
   @override
   Widget build(BuildContext context) {

         final size = MediaQuery.of(context).size;


   return  Container(
      padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),

     
    
         child: ListView.builder(
           itemCount: alineaciones.local.startXi.length,
           itemBuilder: (context,i)
           {
            if(i==0){
                return Column(
                  children: <Widget>[
                  _tecnicos(),
                  Divider(),
                  _alineacion(alineaciones.local.startXi[i],alineaciones.visitante.startXi[i],size)
                  ],
                );
            }else
             return _alineacion(alineaciones.local.startXi[i],alineaciones.visitante.startXi[i],size);
           }
         ),
       

   );
   }


  Widget _alineacion(StartXi local, StartXi visitante,Size size){

    return Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Row(
              children: <Widget>[
                _numero(local.number,local.pos=='G'?Colors.blue[900]:Colors.blue),                
                SizedBox(width: 10,),
               _namePlayer(local.player,size,TextAlign.left)
              ],
            ),
            Row(
              children: <Widget>[
                _namePlayer(visitante.player,size,TextAlign.right),
                SizedBox(width: 10,),
                _numero(visitante.number,local.pos=='G'?Colors.red[900]:Colors.red ),

              ],
            ),

          ],
        )
    );

  }

  Widget _namePlayer(String name,Size size,TextAlign align){

    return  Container(
                width: size.width*0.30,
                child:  Text(
                  name+'',style: _styleTextPlayer, 
                  overflow: TextOverflow.ellipsis,
                  textAlign: align,
                  )
                );
        
   

  }
  Widget _numero(int  numero,Color color){
    if(numero!=null)
    return Container(
      width: 30,
      height: 25,
    
      child: Stack(
        children: <Widget>[

          Icon(FontAwesomeIcons.tshirt,color: color,), 
          Center(child: 
          Text(
          numero.toString(),
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 11),
          )
          )
          

        ],
      )
      );
    else return Container();
  }

  Widget _tecnicos(){



   return Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.chalkboardTeacher,color: Colors.blue,size: 30,),
                SizedBox(width: 13,),
               _tecnico(alineaciones.local.coach,TextAlign.left)

              ],
            ),
            Row(
              children: <Widget>[
              _tecnico(alineaciones.visitante.coach,TextAlign.right),
                SizedBox(width: 13,),
                Icon(FontAwesomeIcons.chalkboardTeacher,color: Colors.red,size: 30),
                  SizedBox(width: 7,),
              ],
            ),

          ],
        )
    );
  }

  Widget _tecnico(String name,TextAlign aling){

    if(name!=null)
    return  Text(name,style: _styleTextPlayer,);
    else
    return Text('Sin técnico ',style: _styleTextPlayer,textAlign: aling,);

  }


 }