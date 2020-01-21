class Equipos {

  List<EquipoModel> items = new List();

  Equipos();

  Equipos.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final equipo = new EquipoModel.fromJson(item);
      items.add( equipo );
    }

  }

}

class EquipoModel {
  
    int teamId;
    String teamName;
    String logo;

    EquipoModel({
        this.teamId,
        this.teamName,
        this.logo,
    });

    factory EquipoModel.fromJson(Map<String, dynamic> json) => EquipoModel(
        teamId: json["team_id"],
        teamName: json["team_name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "team_name": teamName,
        "logo": logo,
    };
      String getEscudo() {

     if ( logo == null ) {
      return 'https://vignette.wikia.nocookie.net/liga-mx/images/9/9e/Sin_Escudo.png/revision/latest/scale-to-width-down/340?cb=20170224183601&path-prefix=es';
    } else {
      return logo;
    }
    }
}
