
// import 'package:intl/intl.dart';

 
import 'package:resultados_futbol/src/models/liga_model.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';

class Funciones{



// agrupa los partidos segun sus ligas
static  List<LigaModel> fixtureOrderByLeague(List<PartidoModel> partidos)
  {

      List<LigaModel> ligas= new List();

      _ordenarPorId(partidos);
      

      // agrego todas las ligas
      partidos.forEach((partido){

        if(!_verificar(ligas, partido.leagueId))
        {
          // print(partido.leagueId);
          ligas.add(LigaModel.fromJson( partido.league.toJson(),partido.leagueId));
          
        }

      });


      //agrego todos los partidos a cada liga

      ligas.forEach((liga){

       liga.partidos= new List();
       partidos.forEach((partido){

         if(partido.leagueId==liga.id)liga.partidos.add(partido);

       });

      });


      return ligas;
    

  }

  static void _ordenarPorId(List<PartidoModel> partidos)
  {
    partidos.sort((a, b) => a.leagueId.compareTo(b.leagueId));


  // var strings = ["c", "bb", "b", "cc", null, "a", 'ccc'];
  // var data = new Collection<String>(strings);
  // var query = data.orderBy((s) => s).thenBy((s) => s.length);  
  // print(query.asIterable());  
  // print(query.toList());
  }

// verifica si la liga ya fue agregada
  static bool _verificar( List<LigaModel> ligas, int idLiga)
  {
    bool encontrado=false;
    ligas.forEach((liga){

        if(liga.id==idLiga){
          encontrado=true;
          return ;
        }
    });

    return encontrado;
  }

//  static  getHourOfDateTime(String d){

// // print(d.);
  
// //  print(d.toString());
//  print(d.substring(11,16));
// //  print(d.hour);
//   // String formatted = DateFormat('Hm').format(d);
//   // print(formatted); // something like 2013-04-20
//   }
 
}