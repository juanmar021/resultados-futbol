import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/providers/partidos_provider.dart';
import 'package:resultados_futbol/src/utils/Funciones.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget.dart' as widget;



class PartidosPage extends StatefulWidget {
 
  @override
  _PartidosPageState createState() => _PartidosPageState();
}

class _PartidosPageState extends State<PartidosPage> {
  final PartidosProvider partidosProvider = new PartidosProvider();
  String fechaPartidos;

  @override
  Widget build(BuildContext context) {
    fechaPartidos= DateFormat("yyyy-MM-dd").format( DateTime.now());
    return Scaffold(
      appBar:_appBar(context),
      body: _cargarPartidos(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        onPressed: (){},
        child: Icon(Icons.live_tv),

      ),
      bottomNavigationBar: BottomNavigationBar(

        items:<BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_left),
            title: Text('Todos')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Mis equipos')
          ),
        ] ,
      ),

      
    );
   
  }

  Widget _cargarPartidos(){
    
    // OPTENEMOS LA FECHA ACTUAL
 
      return FutureBuilder(
      future: partidosProvider.getPartidos(fechaPartidos),
      builder: (BuildContext context, AsyncSnapshot<List<PartidoModel>> snapshot) {
        
        if ( snapshot.hasData ) {
         
          return widget.Partidos( ligas:  Funciones.fixtureOrderByLeague(snapshot.data));
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

  Widget _appBar(BuildContext context)
  {
 return AppBar(
        title: Center(
        child: Column(
          children: <Widget>[
            Text('PARTIDOS'),
            Text('$fechaPartidos',style: TextStyle(fontSize: 14))
          ],
        )),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: ()=>_selectDate(context),
            ),
            
            // child: Icon(Icons.calendar_today)
            )
        ],
      );
  }

    _selectDate(BuildContext context) async {

    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2021),
      locale: Locale('es', 'ES')
    );

    if ( picked != null ) {

      print(picked.toString());
      setState(() {
      fechaPartidos= DateFormat("yyyy-MM-dd").format(picked);
      });
      // setState(() {
      //     _fecha = picked.toString();
      //     _inputFieldDateController.text = _fecha;
      // }); 
    }

  }

}