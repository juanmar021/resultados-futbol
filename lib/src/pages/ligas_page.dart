import 'package:flutter/material.dart';
 
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/providers/partidos_provider.dart';
import 'package:resultados_futbol/src/widgets/app_bar.dart';
import 'package:resultados_futbol/src/widgets/ligas_widget.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';




class LigasPage extends StatelessWidget {


  final PartidosProvider partidosProvider = new PartidosProvider();
 
  @override
  Widget build(BuildContext context) {
  
    final ligasBloc = Provider.mainBloc(context);
    ligasBloc.cargarLigas();
 
    return Scaffold(
      appBar:MyAppBar(
        title: 'LIGAS',
        appBar: AppBar(),
      ),
      body: _cargarLigas(ligasBloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        onPressed: (){},
        child: Icon(Icons.live_tv),

      ),
      bottomNavigationBar: NavBarBottom()

      
    );
   
  }

  Widget _cargarLigas(MainBloc ligasBloc){
    
    // OPTENEMOS LA FECHA ACTUAL
 
      return StreamBuilder(
      stream: ligasBloc.ligasStream,
      builder: (BuildContext context, AsyncSnapshot<List<LigaModel>> snapshot) {
        
        if ( snapshot.hasData ) {
         
          return Ligas( 
            ligas:  snapshot.data
            );
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