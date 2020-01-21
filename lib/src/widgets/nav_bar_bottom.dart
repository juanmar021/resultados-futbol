


import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/equipo_model.dart';



class NavBarBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    PartidosBloc bloc = Provider.partidosBloc(context);

    // prefs.equiposFavoritos=[EquipoModel(logo: 'logodel.png',teamId: 123,teamName: 'barcelona fc')];

    // print(prefs.equiposFavoritos.toString());
    return Container(
      child: BottomNavigationBar(

        items:<BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_left),
            title: Text('Todos')
          ),
          BottomNavigationBarItem(
            icon: _getIconFavorite(bloc),
            title: Text('Mis equipos')
          ),
        ] ,
      ),
    );
  }

  Widget _getIconFavorite(PartidosBloc bloc)
  {
      return StreamBuilder(
        stream: bloc.equiposFavoritosStream,
        builder: (context, AsyncSnapshot<List<EquipoModel>> snapShot ){

          if(snapShot.hasData){

            return Badge(
                      badgeContent: Text(snapShot.data.length.toString(),style: TextStyle(color: Colors.white),),
                      child: Icon(Icons.favorite),
                    );


          }else
          {
            return Icon(Icons.favorite);
          }
        }
      );
  }
}