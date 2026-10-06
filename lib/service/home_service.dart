import 'package:dio/dio.dart';
import 'package:football/utils/dio_connector.dart';

class HomeService {
  static Future<Response> getHeadlines() async {
    return await DioConnector.dio.get("headlines");
  }

  static Future<Response> getUpcoming() async {
    return await DioConnector.dio.get("upcoming");
  }

  static Future<Response> getCurrentMatch() async {
    return await DioConnector.dio.get("current");
  }

  static Future<Response> getPointsTable() async {
    return await DioConnector.dio.get(
      "points_table",
      queryParameters: {"season_id": 1},
    );
  }

  static Future<Response> getPlayersWithStats() async {
    return await DioConnector.dio.get(
      "players-with-stats",
      queryParameters: {"page": 1, "limit": 10},
    );
  }

  static Future<Response> getSponsors() async {
    return await DioConnector.dio.get("sponsors");
  }

  static Future<Response> getTeams() async {
    return await DioConnector.dio.get("teams");
  }
}
