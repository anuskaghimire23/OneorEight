import 'package:football/utils/dio_connector.dart';
import 'package:football/model/points_table_model.dart';

class PointsTableStatusModel {
    PointsTableStatusModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<Datum> data;
    final String? message;

    factory PointsTableStatusModel.fromJson(Map<String, dynamic> json){ 
        return PointsTableStatusModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            message: json["message"],
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.playerId,
        required this.seasonId,
        required this.appearance,
        required this.goals,
        required this.assists,
        required this.redCards,
        required this.yellowCards,
        required this.cleanSheets,
        required this.save,
        required this.position,
        required this.createdAt,
        required this.updatedAt,
        required this.player,
        required this.team,
    });

    final int? id;
    final int? playerId;
    final int? seasonId;
    final int? appearance;
    final int? goals;
    final dynamic assists;
    final int? redCards;
    final int? yellowCards;
    final int? cleanSheets;
    final int? save;
    final String? position;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Player? player;
    final TeamModel? team;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            playerId: json["player_id"],
            seasonId: json["season_id"],
            appearance: json["appearance"],
            goals: json["goals"],
            assists: json["assists"],
            redCards: json["red_cards"],
            yellowCards: json["yellow_cards"],
            cleanSheets: json["clean_sheets"],
            save: json["save"],
            position: json["position"] ?? json["player_position"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            player: json["player"] == null ? null : Player.fromJson(json["player"]),
            team: json["team"] != null 
                ? TeamModel.fromJson(json["team"]) 
                : (json["player"] != null && json["player"]["team"] != null 
                    ? TeamModel.fromJson(json["player"]["team"]) 
                    : null),
        );
    }

}

class Player {
    Player({
        required this.id,
        required this.name,
        required this.image,
        required this.position,
    });

    final int? id;
    final String? name;
    final String? image;
    final String? position;

    factory Player.fromJson(Map<String, dynamic> json){ 
        String img = json["image"] ?? "";
        if (img.isNotEmpty && !img.startsWith('http')) {
            img = DioConnector.dio.options.baseUrl.replaceAll('/api/', '/storage/') + img;
        }

        return Player(
            id: json["id"],
            name: json["name"],
            image: img,
            position: json["position"] ?? json["player_position"] ?? "-",
        );
    }

}
