import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/widgets/app_bar.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget.dart';



class PartidosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   final partidosBloc = Provider.mainBloc(context);

    return Container(
      child: Scaffold(
        appBar:MyAppBar(
          title: 'PARTIDOS',
          appBar: AppBar(),
        ),
        body:_mostrarPartidos(partidosBloc),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

        onPressed: (){},
        child: Icon(Icons.live_tv),

       ),

        
        bottomNavigationBar: NavBarBottom()

      ),
    );
  }

  Widget _mostrarPartidos(MainBloc partidosBloc)
  {

    return StreamBuilder(

      stream: partidosBloc.partidosStream,
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