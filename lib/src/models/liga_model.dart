


import 'package:resultados_futbol/src/models/partido_model.dart';

class LigaModel{


    int id;
    String name;
    String country;
    String logo;
    String flag;
    List<PartidoModel> partidos;

    LigaModel({
        this.id,
        this.name,
        this.country,
        this.logo,
        this.flag,
        this.partidos
    });

       factory LigaModel.fromJson(Map<String, dynamic> json,int idLeague) => LigaModel(
        id: idLeague,
        name: json["name"],
        country: json["country"],
        logo: json["logo"] == null ? null : json["logo"],
        flag: json["flag"] == null ? null : json["flag"],
    );

    String getEscudo() {

     if ( logo == null ) {
      return 'https://vignette.wikia.nocookie.net/liga-mx/images/9/9e/Sin_Escudo.png/revision/latest/scale-to-width-down/340?cb=20170224183601&path-prefix=es';
    } else {
      return logo;
    }

  }


}