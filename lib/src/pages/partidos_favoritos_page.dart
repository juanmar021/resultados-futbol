import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/equipo_model.dart';
import 'package:resultados_futbol/src/widgets/button_nav_bar.dart';
import 'package:resultados_futbol/src/widgets/load_image.dart';
import 'package:resultados_futbol/src/widgets/nav_bar_bottom.dart';


class EquiposFavoritosPage extends StatelessWidget {

    final _scaffoldKey = GlobalKey<ScaffoldState>();

 
  @override
  Widget build(BuildContext context) {

   final bloc = Provider.partidosBloc(context);

 
 
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Center(child: Text('FAVORITOS'),),
      ),
      // body: Loading(mensaje: 'Cargando ligas...',),
      body:_cargarFavoritos(bloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:ButtonNavBar(pageSeleted: 1,),
      bottomNavigationBar: NavBarBottom(pageSeleted: 1)

      
    );
  }

  Widget _cargarFavoritos(PartidosBloc bloc){

    return StreamBuilder(
      stream: bloc.equiposFavoritosStream,
      builder: (BuildContext context, AsyncSnapshot<List<EquipoModel>> snaptShot){

          if(snaptShot.hasData){


            if(snaptShot.data.length>0){
            return ListView.builder(
              itemCount: snaptShot.data.length,
              itemBuilder: (BuildContext context, int i){
                 
                 EquipoModel equipo= snaptShot.data[i];

                  return ListTile(

                    leading: LoadImage(url: equipo.getEscudo(),width: 30,height: 30,),
                    title: Text(equipo.teamName),
                    trailing: GestureDetector(
                      onTap: ()=>_eliminarFavorito(bloc,snaptShot.data,equipo.teamId),
                      child: Icon(Icons.remove_circle, color:Colors.red)
                      ),


                  );

              }

            );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.calendar_today,size: 50,color: Colors.grey[400],),
                    Text('No tiene equipos favoritos',style: Theme.of(context).textTheme.title)
                  ],
                ),
              );
            }
       



          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        
      }

    );


  }

  _eliminarFavorito(PartidosBloc bloc, List<EquipoModel> equipos,int idDelete) {
  
 
    equipos.removeWhere((e)=>idDelete==e.teamId);
    _displaySnackBar('Equipo eliminado de favoritos');

    bloc.setEquiposFavoritos(equipos);
     
 
  }


 _displaySnackBar(String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje),duration: Duration(milliseconds: 800),);
    _scaffoldKey.currentState.showSnackBar(snackBar);   
}


}