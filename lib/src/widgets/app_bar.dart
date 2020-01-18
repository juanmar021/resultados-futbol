
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';


class MyAppBar extends StatelessWidget  implements PreferredSizeWidget{

   final String title;
   final AppBar appBar;
 

  /// you can add more fields that meet your needs

  const MyAppBar({@required this.title,Key key, this.appBar, })
      : super(key: key);
 

  @override
  Widget build(BuildContext context) {
        final bloc = Provider.mainBloc(context);

    return  AppBar(
        title: Center(
        child: Container(        
          child: Column(
            children: <Widget>[
              Text(title.toUpperCase()),
              _getFecha(bloc)
            ],
          ),
        )),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: ()=>_selectDate(context,bloc),
            ),
            
            // child: Icon(Icons.calendar_today)
            )
        ],
      );
    
  }

    _getFecha(MainBloc bloc)
    {
      return StreamBuilder(
        stream: bloc.fechaPartidosStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData){

            return Text(snapshot.data,style: TextStyle(fontSize: 14));

          }else{

            return Text('0000-00-00',style: TextStyle(fontSize: 14));

          }
        },
      );
    }
    _selectDate(BuildContext context,MainBloc bloc) async {

    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2021),
      locale: Locale('es', 'ES')
    );

    if ( picked != null ) {

      print(picked.toString());
      bloc.setFechaPartidos(DateFormat("yyyy-MM-dd").format(picked));
      bloc.cargarLigas();
      // setState(() {
      // _fechaPartidos= DateFormat("yyyy-MM-dd").format(picked);
      // });
      // setState(() {
      //     _fecha = picked.toString();
      //     _inputFieldDateController.text = _fecha;
      // }); 
    }

  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}