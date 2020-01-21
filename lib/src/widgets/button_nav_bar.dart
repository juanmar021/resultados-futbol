import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/services/api_response.dart';


class ButtonNavBar extends StatelessWidget {

  final int pageSeleted;

  ButtonNavBar({@required this.pageSeleted});
 
  @override
  Widget build(BuildContext context) {

    PartidosBloc bloc= Provider.partidosBloc(context);
    
    return StreamBuilder(
      stream: bloc.partidosEnvivoStream,
      builder: (context,AsyncSnapshot<ApiResponse<List<LigaModel>>>  snapShot){

        if(snapShot.hasData){

        if(snapShot.data.data.length>0){
          
        return  FloatingActionButton(

        onPressed: (){
          if(pageSeleted!=2)
          Navigator.pushNamed(context, 'partidos/online');
        },
        child: Badge(
          // badgeContent: Text('',style: TextStyle(color: Colors.white),),
          position: BadgePosition(bottom: 17.0,right: -1.0),
          child: Icon(
            Icons.wifi_tethering,
            color: pageSeleted==2?Colors.greenAccent:Colors.white,),
        ),

      );

        }else{

        return  FloatingActionButton(

        onPressed: (){
          if(pageSeleted!=2)
          Navigator.pushNamed(context, 'partidos/online');
        },
        child: Icon(
          Icons.wifi_tethering,
          color: pageSeleted==2?Colors.greenAccent:Colors.white,),

        );
        }



        }else{
        return  FloatingActionButton(

        onPressed: (){
          if(pageSeleted!=2)
          Navigator.pushNamed(context, 'partidos/online');
        },
        child: Icon(
          Icons.wifi_tethering,
          color: pageSeleted==2?Colors.greenAccent:Colors.white,),

        );
        }

      }
      );
}
}
