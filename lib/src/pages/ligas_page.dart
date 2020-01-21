import 'package:flutter/material.dart';

import 'package:resultados_futbol/src/bloc/ligas_bloc.dart';
 
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/services/api_response.dart';
import 'package:resultados_futbol/src/widgets/app_bar.dart';
import 'package:resultados_futbol/src/widgets/ligas_widget.dart';
import 'package:resultados_futbol/src/widgets/loading_widget.dart';
import 'package:resultados_futbol/src/widgets/error_widget.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';




class LigasPage extends StatelessWidget {


 
  @override
  Widget build(BuildContext context) {
  
    final ligasBloc = Provider.ligasBloc(context);
 
 
    return Scaffold(
      appBar:MyAppBar(
        title: 'LIGAS',
        appBar: AppBar(),
      ),
      // body: Loading(mensaje: 'Cargando ligas...',),
      body: _cargarLigas(ligasBloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        onPressed: (){},
        child: Icon(Icons.wifi_tethering),

      ),
      bottomNavigationBar: NavBarBottom()

      
    );
   
  }

  Widget _cargarLigas(LigasBloc ligasBloc){
    

 
      return StreamBuilder(
      stream: ligasBloc.ligasStream,
      builder: (BuildContext context, AsyncSnapshot<ApiResponse<List<LigaModel>>> snapshot) {
        if(snapshot.hasData){
        switch (snapshot.data.status) {
          
                case Status.LOADING:
                  return Loading(mensaje: snapshot.data.message);
                  break;
                case Status.COMPLETED:
             
                  return Ligas(ligas: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    reintentarAction: ligasBloc.cargarLigas,
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