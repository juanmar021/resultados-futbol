import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
 


class Ligas extends StatelessWidget {
 
   final List<LigaModel> ligas;
 
   Ligas({ @required this.ligas});
   
  @override
  Widget build(BuildContext context) {
       final partidosBloc = Provider.partidosBloc(context);


    return Container(
      child: _cargarLigas(context,partidosBloc),
    );
  }


  Widget _cargarLigas(BuildContext _context,PartidosBloc partidosBloc)
  {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
            if(i==0){
              return Column(
                children: <Widget>[
                  _todosLosPartidos(context,partidosBloc),
                  Divider(),
                  _liga(ligas[i],_context,partidosBloc)

                ],
              );
            }
            else  return _liga(ligas[i],_context,partidosBloc);
      },
      itemCount: ligas.length
     );
  }
  
  Widget _liga(LigaModel liga,BuildContext context, PartidosBloc partidosBloc){

        return Container(
         child: Column(
           children: <Widget>[
              ListTile(

              
                leading: Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture(                    
                      AdvancedNetworkSvg(
                        liga.getBandera(),
                        SvgPicture.svgByteDecoder,
                 
                      ),
                      // placeholderBuilder: (context) => CircularProgressIndicator(),
                  
                    ),
                ),
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
                       partidosBloc.setPartidos(l)  ;    
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

  Widget _todosLosPartidos(BuildContext context,PartidosBloc partidosBloc)
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
           partidosBloc.setPartidos(ligas)  ;    
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