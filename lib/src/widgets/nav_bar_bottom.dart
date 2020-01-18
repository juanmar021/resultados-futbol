
import 'package:flutter/material.dart';



class NavBarBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(

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
}