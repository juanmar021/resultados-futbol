import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';

import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/widgets/app_bar.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget.dart';




class PartidosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   final bloc = Provider.partidosBloc(context);

   bloc.setPageSeleted(0);

    return Container(
      child: Scaffold(
        appBar:MyAppBar(
          title: 'PARTIDOS',
          appBar: AppBar(),
        ),
        body:_mostrarPartidos(bloc),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

        onPressed: (){},
        child: Icon(Icons.wifi_tethering),

       ),

        
        bottomNavigationBar: NavBarBottom()

      ),
    );
  }

  Widget _mostrarPartidos(PartidosBloc bloc)
  {

    return StreamBuilder(

      stream: bloc.partidosStream,
      builder: (BuildContext context, AsyncSnapshot<List<LigaModel>> snapshot){

        if ( snapshot.hasData ) {
         
        
          return Partidos( 
            ligas:  snapshot.data
            );
          // return Text('HAY DATA');
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }


      },

    );

  }
}