


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
    return _crearNavBar(bloc);
  }

  Widget _crearNavBar(PartidosBloc bloc){

    return StreamBuilder(
      stream:  bloc.pageSelectedStream,
      builder: (BuildContext context,AsyncSnapshot<int> snapShot){

        if(snapShot.hasData){
          return Container(
          child: BottomNavigationBar(

            items:<BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: ()=>_navigate(context,0,snapShot.data),
                  child: Icon(
                    Icons.format_align_left,
                    color:snapShot.data==0? Theme.of(context).primaryColor:Colors.grey[600]),
                  ),
                title: Text(
                  'Todos',
                  style: TextStyle(color: snapShot.data==0? Theme.of(context).primaryColor:Colors.grey[600]),)
              ),
              BottomNavigationBarItem(
                icon: _getIconFavorite(bloc,snapShot.data==1? Theme.of(context).primaryColor:Colors.grey[600],snapShot.data),
                title: Text(
                  'Mis equipos',
                   style:TextStyle(color:snapShot.data==1? Theme.of(context).primaryColor:Colors.grey[600])
                  )
              ),
            ] ,
          ),
        );
        }
        else{
          return Container();
        }

      }

    );
  }

  Widget _getIconFavorite(PartidosBloc bloc,Color color ,int pageIndexCurrent)
  {
      return StreamBuilder(
        stream: bloc.equiposFavoritosStream,
        builder: (context, AsyncSnapshot<List<EquipoModel>> snapShot ){

          if(snapShot.hasData){

            return Badge(
                      badgeContent: Text(snapShot.data.length.toString(),style: TextStyle(color: Colors.white),),
                      child: GestureDetector(
                        onTap: ()=>_navigate(context,1,pageIndexCurrent),
                        child: Icon(Icons.favorite,color: color,)
                        ),
                    );


          }else
          {

            return GestureDetector(
              onTap: ()=>_navigate(context,1,pageIndexCurrent),
              child: Icon(Icons.favorite,color: color)
              );
          }
        }
      );
  }

  void _navigate(BuildContext context, int pageIndex, int pageIndexCurrent)
  {
    if(pageIndexCurrent!=pageIndex){
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