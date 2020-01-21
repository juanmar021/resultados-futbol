


import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/equipo_model.dart';



class NavBarBottom extends StatelessWidget {

  final int pageSeleted;

  NavBarBottom({@required this.pageSeleted});

  @override
  Widget build(BuildContext context) {

    PartidosBloc bloc = Provider.partidosBloc(context);
 
    // prefs.equiposFavoritos=[EquipoModel(logo: 'logodel.png',teamId: 123,teamName: 'barcelona fc')];

    // print(prefs.equiposFavoritos.toString());
    return _crearNavBar(context,bloc);
  }

  Widget _crearNavBar(BuildContext context,PartidosBloc bloc){

 return Container(
           child: BottomNavigationBar(

            items:<BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: ()=>_navigate(context,0),
                  child: Icon(
                    Icons.format_align_left,
                    color:pageSeleted==0? Theme.of(context).primaryColor:Colors.grey[600]),
                  ),
                title: Text(
                  'Todos',
                  style: TextStyle(color: pageSeleted==0? Theme.of(context).primaryColor:Colors.grey[600]),)
              ),
              BottomNavigationBarItem(
                icon: _getIconFavorite(bloc,pageSeleted==1? Theme.of(context).primaryColor:Colors.grey[600]),
                title: Text(
                  'Mis equipos',
                   style:TextStyle(color:pageSeleted==1? Theme.of(context).primaryColor:Colors.grey[600])
                  )
              ),
            ] ,
          ),
        );
  }

  Widget _getIconFavorite(PartidosBloc bloc,Color color )
  {
      return StreamBuilder(
        stream: bloc.equiposFavoritosStream,
        builder: (context, AsyncSnapshot<List<EquipoModel>> snapShot ){

          if(snapShot.hasData){

            return Badge(
                      badgeContent: Text(snapShot.data.length.toString(),style: TextStyle(color: Colors.white),),
                      child: GestureDetector(
                        onTap: ()=>_navigate(context,1),
                        child: Icon(Icons.favorite,color: color,)
                        ),
                    );


          }else
          {

            return GestureDetector(
              onTap: ()=>_navigate(context,1),
              child: Icon(Icons.favorite,color: color)
              );
          }
        }
      );
  }

  void _navigate(BuildContext context, int pageIndex)
  {
    if(pageSeleted!=pageIndex){
        switch (pageIndex){
              case 0:
              
                Navigator.pushNamed(context, 'ligas');
                // bloc.setPageSeleted(pageIndex);
              break;

              default:
                Navigator.pushNamed(context, 'equipos/favoritos');
                // bloc.setPageSeleted(pageIndex);
              break;
        }
    }
   
  }
}