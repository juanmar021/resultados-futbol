import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resultados_futbol/src/bloc/provider.dart';
import 'package:resultados_futbol/src/pages/ligas_page.dart';


import 'package:resultados_futbol/src/pages/partidos_page.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
         localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('es', 'ES'),
        ],
        theme: ThemeData(      
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'ligas',
        routes: {
            'ligas'          : ( BuildContext context ) => LigasPage(),      
            'partidos'       : ( BuildContext context ) => PartidosPage()        
        },
       

      ),
    );
  }
}

 