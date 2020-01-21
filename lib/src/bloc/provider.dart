
import 'package:flutter/material.dart';

import 'package:resultados_futbol/src/bloc/ligas_bloc.dart';
import 'package:resultados_futbol/src/bloc/partidos_bloc.dart';



class Provider extends InheritedWidget {

  final _ligasBloc      = new LigasBloc();
  final _partidosBloc      = new PartidosBloc();



  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LigasBloc ligasBloc ( BuildContext context ) {
    return ( context.dependOnInheritedWidgetOfExactType<Provider>())._ligasBloc;
  }

 static PartidosBloc partidosBloc ( BuildContext context ) {
    return ( context.dependOnInheritedWidgetOfExactType<Provider>())._partidosBloc;
  }


}