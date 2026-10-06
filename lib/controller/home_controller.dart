// import 'package:football/model/points_table_model.dart';
// import 'package:football/model/point_status_model.dart';
// import 'package:football/model/sponsor_model.dart';
// import 'package:football/service/home_service.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   var isLoading = false.obs;
//   var headlines = <dynamic>[].obs;
//   var upcomingMatch = Rxn<dynamic>();
//   var currentMatch = Rxn<dynamic>();
//   var pointsTable = <PointsTableModel>[].obs;
//   dynamic players = <Datum>[].obs;
//   var playerTeamIdMap = <int, int>{}.obs;
//   var playerPositionMap = <int, String>{}.obs;
//   // var sponsors = <SponsorModel>[].obs;
//   var sponsors = <Doc>[].obs;

//   Future<void> getHomeData() async {
//     try {
//       isLoading.value = true;

//       try {
//         final response = await HomeService.getHeadlines();
//         headlines.value = response.data["docs"] ?? [];

//         print("Headlines: ${headlines.length}");
//       } catch (e) {
//         print("Headline Error: $e");
//       }

//       try {
//         final response = await HomeService.getUpcoming();

//         upcomingMatch.value = response.data["data"];

//         print("Upcoming: ${upcomingMatch.value}");
//       } catch (e) {
//         print("Upcoming Error: $e");
//       }
//       // current match

//       try {
//         final response = await HomeService.getCurrentMatch();

//         currentMatch.value = response.data["data"];

//         print("Current: ${currentMatch.value}");
//       } catch (e) {
//         print("Current Error: $e");
//       }

//       // pointstable

//       try {
//         final response = await HomeService.getPointsTable();

//         final List data = response.data["data"] ?? [];

//         print("POINTS TABLE API COUNT: ${data.length}");

//         pointsTable.value = data
//             .map<PointsTableModel>((item) => PointsTableModel.fromJson(item))
//             .toList();

//         print("POINTS TABLE CONTROLLER COUNT: ${pointsTable.length}");

//         for (var item in pointsTable) {
//           print(
//             "${item.teamId} - ${item.team.teamName} - ${item.team.teamLogo}",
//           );
//         }
//       } catch (e) {
//         print("Points Table Error: $e");
//       }

//       // Teams to player mapping

//       try {
//         final response = await HomeService.getTeams();

//         final List data = response.data["docs"] ?? [];

//         final Map<int, int> teamMap = {};
//         final Map<int, String> positionMap = {};

//         for (var team in data) {
//           final int teamId = team["id"] ?? 0;
//           final List pList = team["players"] ?? [];

//           for (var p in pList) {
//             if (p["id"] != null) {
//               final int playerId = p["id"];

//               teamMap[playerId] = teamId;

//               positionMap[playerId] = p["position"] ?? "-";
//             }
//           }
//         }

//         playerTeamIdMap.value = teamMap;
//         playerPositionMap.value = positionMap;

//         print("PLAYER TEAM MAP COUNT: ${teamMap.length}");
//         print("PLAYER POSITION MAP COUNT: ${positionMap.length}");
//       } catch (e) {
//         print("Teams mapping Error: $e");
//       }

//       try {
//         final response = await HomeService.getPlayersWithStats();

//         final List data = response.data["data"] ?? [];

//         players.value = data
//             .map<Datum>((item) => Datum.fromJson(item))
//             .toList();

//         print("Players: ${players.length}");
//       } catch (e) {
//         print("Players Error: $e");
//       }

//       // sponsors

//       try {
//         final response = await HomeService.getSponsors();

//         final sponsorModel = SponsorModel.fromJson(response.data);

//         sponsors.value = sponsorModel.docs;

//         print("Sponsors: ${sponsors.length}");
//       } catch (e) {
//         print("Sponsors Error: $e");
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     getHomeData();
//   }
// }
import 'package:football/model/points_table_model.dart';
import 'package:football/model/point_status_model.dart';
import 'package:football/model/sponsor_model.dart';
import 'package:football/service/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var headlines = <dynamic>[].obs;
  var upcomingMatch = Rxn<dynamic>();
  var currentMatch = Rxn<dynamic>();

  var pointsTable = <PointsTableModel>[].obs;

  dynamic players = <Datum>[].obs;

  var playerTeamIdMap = <int, int>{}.obs;
  var playerPositionMap = <int, String>{}.obs;

  var sponsors = <Doc>[].obs;

  Future<void> getHomeData() async {
    isLoading.value = true;

    try {
      // Get headlines
      try {
        final response = await HomeService.getHeadlines();

        headlines.value = response.data["docs"] ?? [];

        print("Headlines: ${headlines.length}");
      } catch (e) {
        print("Headline Error: $e");
      }

      // Get upcoming match
      try {
        final response = await HomeService.getUpcoming();

        upcomingMatch.value = response.data["data"];

        print("Upcoming: ${upcomingMatch.value}");
      } catch (e) {
        print("Upcoming Error: $e");
      }

      // Get current match
      try {
        final response = await HomeService.getCurrentMatch();

        currentMatch.value = response.data["data"];

        print("Current: ${currentMatch.value}");
      } catch (e) {
        print("Current Error: $e");
      }

      // Get points table
      try {
        final response = await HomeService.getPointsTable();

        final List data = response.data["data"] ?? [];

        print("POINTS TABLE API COUNT: ${data.length}");

        pointsTable.value = data
            .map<PointsTableModel>((item) => PointsTableModel.fromJson(item))
            .toList();

        print("POINTS TABLE CONTROLLER COUNT: ${pointsTable.length}");

        for (var item in pointsTable) {
          print(
            "${item.teamId} - "
            "${item.team.teamName} - "
            "${item.team.teamLogo}",
          );
        }
      } catch (e) {
        print("Points Table Error: $e");
      }

      // Create player-team and player-position mapping
      try {
        final response = await HomeService.getTeams();

        final List data = response.data["docs"] ?? [];

        final Map<int, int> teamMap = {};
        final Map<int, String> positionMap = {};

        for (var team in data) {
          final int teamId = team["id"] ?? 0;
          final List playerList = team["players"] ?? [];

          for (var player in playerList) {
            if (player["id"] != null) {
              final int playerId = player["id"];

              teamMap[playerId] = teamId;
              positionMap[playerId] = player["position"] ?? "-";
            }
          }
        }

        playerTeamIdMap.value = teamMap;
        playerPositionMap.value = positionMap;

        print("PLAYER TEAM MAP COUNT: ${teamMap.length}");
        print("PLAYER POSITION MAP COUNT: ${positionMap.length}");
      } catch (e) {
        print("Teams mapping Error: $e");
      }

      // Get players with statistics
      try {
        final response = await HomeService.getPlayersWithStats();

        final List data = response.data["data"] ?? [];

        players.value = data
            .map<Datum>((item) => Datum.fromJson(item))
            .toList();

        print("Players: ${players.length}");
      } catch (e) {
        print("Players Error: $e");
      }

      // Get sponsors
      try {
        final response = await HomeService.getSponsors();

        final sponsorModel = SponsorModel.fromJson(response.data);

        sponsors.value = sponsorModel.docs;

        print("Sponsors: ${sponsors.length}");
      } catch (e) {
        print("Sponsors Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    getHomeData();
  }
}
