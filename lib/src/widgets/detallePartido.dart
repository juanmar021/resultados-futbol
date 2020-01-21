
import 'package:flutter/material.dart';
import 'package:resultados_futbol/src/models/partido_model.dart';
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
               child: SingleChildScrollView(


                 child:  _crearTabContent()                
                    
                 
               ),
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
      return Text('TAB O CONTENT');
      case 1: 
      return EventosPartido(eventos: widget.partido.eventos,idEquipoLocal: widget.partido.homeTeam.teamId,);
      default: 
      return Text('TAB 2 CONTENT');

    }
  }
}