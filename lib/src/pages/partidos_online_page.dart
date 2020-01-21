import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/services/api_response.dart';
import 'package:resultados_futbol/src/widgets/button_nav_bar.dart';
import 'package:resultados_futbol/src/widgets/loading_widget.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget.dart';
import 'package:resultados_futbol/src/widgets/error_widget.dart';



class PartidosOnlinePage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
     final bloc = Provider.partidosBloc(context);


    return Container(
      child: Scaffold(
        appBar:AppBar(title: Center(child: Text('EN VIVO'),),),
        body:_mostrarPartidos(bloc),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ButtonNavBar(pageSeleted: 2,),        
        bottomNavigationBar: NavBarBottom(pageSeleted: 2)

      ),
    );
  }

 Widget _mostrarPartidos(PartidosBloc bloc)
  {
     return StreamBuilder(
      stream: bloc.partidosEnvivoStream,
      builder: (BuildContext context, AsyncSnapshot<ApiResponse<List<LigaModel>>> snapshot) {
        if(snapshot.hasData){
        switch (snapshot.data.status) {
          
                case Status.LOADING:
                  return Loading(mensaje: snapshot.data.message);
                  break;
                case Status.COMPLETED:

                  if(snapshot.data.data.length>0)             
                  return Partidos(ligas: snapshot.data.data);
                  else
                  return Container(

                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.calendar_today,color:Colors.grey[400],size: 50,),
                          SizedBox(height: 10,),
                          Text('No hay partidos en vivo',style: TextStyle(color:Colors.grey[400],fontSize: 20 ),)
                        ],
                      ),
                    ),

                  );
                  break;
                case Status.ERROR:
                  return Error(
                    reintentarAction: bloc.cargarPartidosEnvivo,
                    mensaje:snapshot.data.message
                    );
               
                  break;
        }
        }

        return Container();
    
        
      },
    );



  }
}