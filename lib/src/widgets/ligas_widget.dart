import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:resultados_futbol/src/bloc/main_bloc.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';



class Ligas extends StatelessWidget {
 
   final List<LigaModel> ligas;
 
   Ligas({ @required this.ligas});
   
  @override
  Widget build(BuildContext context) {
       final ligasBloc = Provider.mainBloc(context);

    return Container(
      child: _cargarLigas(context,ligasBloc),
    );
  }


  Widget _cargarLigas(BuildContext _context,MainBloc ligasBloc)
  {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
            if(i==0){
              return Column(
                children: <Widget>[
                  _todosLosPartidos(context,ligasBloc),
                  Divider(),
                  _liga(ligas[i],_context,ligasBloc)

                ],
              );
            }
            else  return _liga(ligas[i],_context,ligasBloc);
      },
      itemCount: ligas.length
     );
  }
  
  Widget _liga(LigaModel liga,BuildContext context, MainBloc ligasBloc){

        return Container(
         child: Column(
           children: <Widget>[
              ListTile(
              // leading: SvgPicture.network(
              // liga.getBandera(),
              // placeholderBuilder: (context) => CircularProgressIndicator(),
              // height: 25,
              // ),
              title: _tituloLiga(liga,context),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  liga.partidos.length.toString(),
                  style: TextStyle(fontSize: 15),
                )
                ),                
                onTap: (){
                       List<LigaModel> l= new List();
                       l.add(liga);    
                      //  print(liga.partidos.length.toString());    
                       ligasBloc.setPartidos(l)  ;    
                       Navigator.pushNamed(context, 'partidos');   
                     
                      },
               ),
               
           ],
         ),
       );
     

  }

  Widget _tituloLiga(LigaModel liga,BuildContext context)
  {
    return Row(
      children: <Widget>[
          Text(liga.country+': ', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          Flexible(
              child: Text(
              liga.name,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              ),
          )
          
      ],
    );
  }

  Widget _todosLosPartidos(BuildContext context,MainBloc ligasBloc)
{
    return ListTile(
      title: Text('Todos los partidos',style:Theme.of(context).textTheme.title),
      trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  _contarPartidos(),
                  style: TextStyle(fontSize: 15),
                )
                ),     
      onTap: (){
          ligasBloc.setPartidos(ligas)  ;    
          Navigator.pushNamed(context, 'partidos');  
      },
    );
  }

  String _contarPartidos(){

      int totalPartidos=0;
      ligas.forEach((liga){

        totalPartidos+=liga.partidos.length;

      });

      return totalPartidos.toString();
  }
}