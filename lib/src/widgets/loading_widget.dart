

import 'package:flutter/material.dart';


class Loading extends StatelessWidget {

  final String mensaje;

  Loading({@required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
     
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(mensaje,style: Theme.of(context).textTheme.title)
                ], 
         ),
       )
    );
  }
}