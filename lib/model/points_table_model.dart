import 'package:football/utils/dio_connector.dart';

class PointsTableModel {
  final int id;
  final int seasonId;
  final int teamId;
  final int matchPlayed;
  final int matchWon;
  final int matchLost;
  final int matchDrawn;
  final int goalsFor;
  final int goalsAgainst;
  final int points;
  final String form;
  final TeamModel team;

  PointsTableModel({
    required this.id,
    required this.seasonId,
    required this.teamId,
    required this.matchPlayed,
    required this.matchWon,
    required this.matchLost,
    required this.matchDrawn,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.points,
    required this.form,
    required this.team,
  });

  factory PointsTableModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return PointsTableModel(
      id: parseInt(json['id']),
      seasonId: parseInt(json['season_id']),
      teamId: parseInt(json['team_id']),
      matchPlayed: parseInt(json['match_played']),
      matchWon: parseInt(json['match_won']),
      matchLost: parseInt(json['match_lost']),
      matchDrawn: parseInt(json['match_drawn']),
      goalsFor: parseInt(json['goals_for']),
      goalsAgainst: parseInt(json['goals_against']),
      points: parseInt(json['points']),
      form: json['form']?.toString() ?? '',
      team: json['team'] != null && json['team'] is Map
          ? TeamModel.fromJson(Map<String, dynamic>.from(json['team']))
          : TeamModel(id: 0, teamName: '', teamLogo: ''),
    );
  }
}

class TeamModel {
  final int id;
  final String teamName;
  final String teamLogo;

  TeamModel({required this.id, required this.teamName, required this.teamLogo});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    String logo = json['team_logo']?.toString() ?? '';

    if (logo.isNotEmpty && !logo.startsWith('http')) {
      logo =
          DioConnector.dio.options.baseUrl.replaceAll('/api/', '/storage/') +
          logo;
    }

    return TeamModel(
      id: json['id'] is int ? json['id'] : (int.tryParse(json['id']?.toString() ?? '0') ?? 0),
      teamName: json['team_name']?.toString() ?? '',
      teamLogo: logo,
    );
  }
}
