
class Partidos {

  List<PartidoModel> items = new List();

  Partidos();

  Partidos.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final partido = new PartidoModel.fromJson(item);
      items.add( partido );
    }

  }

}




class PartidoModel {
    int fixtureId;
    int leagueId;
    Liga league;
    String eventDate;
    int eventTimestamp;
    int firstHalfStart;
    int secondHalfStart;
    String round;
    String status;
    String statusShort;
    int elapsed;
    String venue;
    String referee;
    Equipo homeTeam;
    Equipo awayTeam;
    int goalsHomeTeam;
    int goalsAwayTeam;
    Marcador score;

    PartidoModel({
        this.fixtureId,
        this.leagueId,
        this.league,
        this.eventDate,
        this.eventTimestamp,
        this.firstHalfStart,
        this.secondHalfStart,
        this.round,
        this.status,
        this.statusShort,
        this.elapsed,
        this.venue,
        this.referee,
        this.homeTeam,
        this.awayTeam,
        this.goalsHomeTeam,
        this.goalsAwayTeam,
        this.score,
    });

    factory PartidoModel.fromJson(Map<String, dynamic> json) => PartidoModel(
        fixtureId: json["fixture_id"],
        leagueId: json["league_id"],
        league: Liga.fromJson(json["league"]),
        eventDate: json["event_date"],
        eventTimestamp: json["event_timestamp"],
        firstHalfStart: json["firstHalfStart"],
        secondHalfStart: json["secondHalfStart"],
        round: json["round"],
        status: json["status"],
        statusShort: json["statusShort"],
        elapsed: json["elapsed"],
        venue: json["venue"],
        referee: json["referee"] == null ? null : json["referee"],
        homeTeam: Equipo.fromJson(json["homeTeam"]),
        awayTeam: Equipo.fromJson(json["awayTeam"]),
        goalsHomeTeam: json["goalsHomeTeam"],
        goalsAwayTeam: json["goalsAwayTeam"],
        score: Marcador.fromJson(json["score"]),
    );

    Map<String, dynamic> toJson() => {
        "fixture_id": fixtureId,
        "league_id": leagueId,
        "league": league.toJson(),
        "event_date": eventDate,
        "event_timestamp": eventTimestamp,
        "firstHalfStart": firstHalfStart,
        "secondHalfStart": secondHalfStart,
        "round": round,
        "status": status,
        "statusShort": statusShort,
        "elapsed": elapsed,
        "venue": venue,
        "referee": referee == null ? null : referee,
        "homeTeam": homeTeam.toJson(),
        "awayTeam": awayTeam.toJson(),
        "goalsHomeTeam": goalsHomeTeam,
        "goalsAwayTeam": goalsAwayTeam,
        "score": score.toJson(),
    };

   

}

class Equipo {
    int teamId;
    String teamName;
    String logo;

    Equipo({
        this.teamId,
        this.teamName,
        this.logo,
    });

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
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

class Liga {
    String name;
    String country;
    String logo;
    String flag;

    Liga({
        this.name,
        this.country,
        this.logo,
        this.flag,
    });

    factory Liga.fromJson(Map<String, dynamic> json) => Liga(
        name: json["name"],
        country: json["country"],
        logo: json["logo"] == null ? null : json["logo"],
        flag: json["flag"] == null ? null : json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "logo": logo == null ? null : logo,
        "flag": flag == null ? null : flag,
    };
}

class Marcador {
    String halftime;
    String fulltime;
    String extratime;
    String penalty;

    Marcador({
        this.halftime,
        this.fulltime,
        this.extratime,
        this.penalty,
    });

    factory Marcador.fromJson(Map<String, dynamic> json) => Marcador(
        halftime: json["halftime"] == null ? null : json["halftime"],
        fulltime: json["fulltime"],
        extratime: json["extratime"],
        penalty: json["penalty"],
    );

    Map<String, dynamic> toJson() => {
        "halftime": halftime == null ? null : halftime,
        "fulltime": fulltime,
        "extratime": extratime,
        "penalty": penalty,
    };
}
