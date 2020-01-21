
class Partidos {

  List<PartidoModel> items = new List();

  Partidos();

  Partidos.fromJsonList( List<dynamic> jsonList  ) {

      print('from json list');
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
    List<Evento> eventos;
    Lineups lineups;


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
        this.eventos,
        this.lineups,
    });

     PartidoModel.fromJson(Map<String, dynamic> json){
        fixtureId= json["fixture_id"];
        leagueId= json["league_id"];
        league= Liga.fromJson(json["league"]);
        eventDate= json["event_date"];
        eventTimestamp= json["event_timestamp"];
        firstHalfStart= json["firstHalfStart"];
        secondHalfStart= json["secondHalfStart"];
        round= json["round"];
        status= json["status"];
        statusShort= json["statusShort"];
        elapsed= json["elapsed"];
        venue= json["venue"];
        referee= json["referee"] == null ? null : json["referee"];
        homeTeam= Equipo.fromJson(json["homeTeam"]);
        awayTeam= Equipo.fromJson(json["awayTeam"]);
        goalsHomeTeam= json["goalsHomeTeam"];
        goalsAwayTeam= json["goalsAwayTeam"];
        score= Marcador.fromJson(json["score"]);
        eventos= List<Evento>.from(json["events"]!=null?json["events"].map((x) => Evento.fromJson(x)):[]);
        lineups= Lineups.fromJson(json["lineups"],homeTeam.teamName,awayTeam.teamName);

   }

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
        "events": List<dynamic>.from(eventos.map((x) => x.toJson())),
        // "lineups": lineups.toJson(homeTeam.teamName,awayTeam.teamName),

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

class Evento {
    int elapsed;
    int teamId;
    String teamName;
    int playerId;
    String player;
    int assistId;
    String assist;
    String type;
    String detail;

    Evento({
        this.elapsed,
        this.teamId,
        this.teamName,
        this.playerId,
        this.player,
        this.assistId,
        this.assist,
        this.type,
        this.detail,
    });

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        elapsed: json["elapsed"],
        teamId: json["team_id"],
        teamName: json["teamName"],
        playerId: json["player_id"],
        player: json["player"],
        assistId: json["assist_id"] == null ? null : json["assist_id"],
        assist: json["assist"] == null ? null : json["assist"],
        type: json["type"],
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "elapsed": elapsed,
        "team_id": teamId,
        "teamName":  teamName,
        "player_id": playerId,
        "player": player,
        "assist_id": assistId == null ? null : assistId,
        "assist": assist == null ? null : assist,
        "type":  type,
        "detail": detail,
    };
}

class Lineups {
    Team local;
    Team visitante;

    Lineups({
        this.local,
        this.visitante,
    });

    Lineups.fromJson(Map<String, dynamic> json,String _local,String _visitante) {
        if(json!=null){
        local= Team.fromJson(json[_local]);
        visitante= Team.fromJson(json[_visitante]);
        }
       
      }
    // Map<String, dynamic> toJson() => {
    //     "Bordeaux": bordeaux.toJson(),
    //     "Saint Etienne": saintEtienne.toJson(),
    // };
}
class Team {
    int coachId;
    String coach;
    String formation;
    List<StartXi> startXi;
    List<StartXi> substitutes;

    Team({
        this.coachId,
        this.coach,
        this.formation,
        this.startXi,
        this.substitutes,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        coachId: json["coach_id"],
        coach: json["coach"],
        formation: json["formation"],
        startXi: List<StartXi>.from(json["startXI"].map((x) => StartXi.fromJson(x))),
        substitutes: List<StartXi>.from(json["substitutes"].map((x) => StartXi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "coach_id": coachId,
        "coach": coach,
        "formation": formation,
        "startXI": List<dynamic>.from(startXi.map((x) => x.toJson())),
        "substitutes": List<dynamic>.from(substitutes.map((x) => x.toJson())),
    };
}
class StartXi {
    int teamId;
    int playerId;
    String player;
    int number;
    String pos;

    StartXi({
        this.teamId,
        this.playerId,
        this.player,
        this.number,
        this.pos,
    });

    factory StartXi.fromJson(Map<String, dynamic> json) => StartXi(
        teamId: json["team_id"],
        playerId: json["player_id"],
        player: json["player"],
        number: json["number"],
        pos:  json["pos"],
    );

    Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "player_id": playerId,
        "player": player,
        "number": number,
        "pos": pos,
    };
}

 
