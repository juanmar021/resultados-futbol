

import 'package:flutter/material.dart';



class Error extends StatelessWidget {

  final String mensaje;
  final Function reintentarAction;

  Error({@required this.mensaje,@required this.reintentarAction});

  @override
  Widget build(BuildContext context) {
    return Container(
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:<Widget>[
                  _iconError(),
                  SizedBox(height: 20),
                  Text(mensaje),
                  SizedBox(height: 10),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('REINTENTAR'),
                    onPressed: (){reintentarAction();}
                  )
                ], 
            ),
             )
    );
  }

  Widget _iconError(){
      if(mensaje=='Revise su conexión a internet')

               return  Icon(Icons.signal_wifi_off,size: 90,);    
       
      else
               return   Icon(Icons.error_outline,size: 50);       
       
  }
}