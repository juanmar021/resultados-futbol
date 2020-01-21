
import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget/alineacion_partidos.dart';
import 'package:resultados_futbol/src/widgets/partidos_widget/eventos_partidos.dart';



class DetallePartido extends StatefulWidget {

  final PartidoModel partido ;

  const DetallePartido({Key key,@required this.partido}): super(key: key);


  @override
  _DetallePartidoState createState() => _DetallePartidoState();
}



class _DetallePartidoState extends State<DetallePartido>  with SingleTickerProviderStateMixin {
 
 TabController _tabController;

 int _tabSelected=0;
 int length =2;

 

   @override
  void initState() {
    _tabController = new TabController(length: widget.partido.eventos.length>0?length:(length-1), vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      
       return  Container(
         child: Column(
           children: <Widget>[
             _tabsHost(),
              Expanded(
                


                 child:  _mostrarInfo()                
                    
                 
               
             )
            //  _crearTabContent()
              
           ],
         ),
        
     );
     
  
  }


  Widget _tabsHost(){
    return  Container(
      //  padding: EdgeInsets.only(bottom: 1.0),
       decoration: BoxDecoration(
         color: Theme.of(context).primaryColor
       ),
       child:TabBar(
                onTap: (int index){setState(() {
                  _tabSelected=index;
                });},
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,  
                indicatorColor: Colors.white,   
                indicatorWeight: 3.0,
                tabs:_tabs(), 
               controller: _tabController
              
              ),
     );
  }
List<Widget> _tabs(){
  
  List<Widget> tabs = new List();

  tabs.add(Tab(text: 'ALINEACIÓN',));
  if(widget.partido.eventos.length>0)tabs.add(new Tab(text: 'EVENTOS',));
   return tabs;

}
  Widget _crearTabContent(){

    switch(_tabSelected){

      case 0:
      return AlineacionPartidos(alineaciones: widget.partido.lineups,);
      case 1: 
      return EventosPartido(eventos: widget.partido.eventos,idEquipoLocal: widget.partido.homeTeam.teamId,);
      default: 
      return Text('TAB CONTENT');

    }
  }

  Widget _mostrarInfo(){

    if(widget.partido.lineups.local!=null){

        return _crearTabContent();


     }else{

       return Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
                Icon(Icons.calendar_today,size: 50,color: Colors.grey[400],),
                Text('No hay alineación',style: Theme.of(context).textTheme.title)
           ],
         ),
       );
     }
  }
}