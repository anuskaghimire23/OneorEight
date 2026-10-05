import 'package:flutter/material.dart';
import 'package:football/controller/home_controller.dart';
import 'package:football/widgets/allPlayer_widgets.dart';
import 'package:football/widgets/player_stats_widgets.dart';
import 'package:get/get.dart';

class LeagueStandings extends GetView<HomeController> {
  const LeagueStandings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Black heading
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Color(0xff1b1b1b),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LEAGUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "STANDINGS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Last season points table",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                // Season button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffff006f),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.white, size: 16),

                      SizedBox(width: 6),

                      Text(
                        "Season 2026",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 4),

                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Table heading
          _tableHeader(),

          // Data
          Obx(() {
            if (controller.pointsTable.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(30),
                child: Text("No standings available"),
              );
            }

            return Column(
              children: List.generate(controller.pointsTable.take(5).length, (
                index,
              ) {
                final team = controller.pointsTable[index];

                final goalDifference = team.goalsFor - team.goalsAgainst;

                return _teamRow(
                  position: index + 1,
                  teamName: team.team.teamName,
                  teamLogo: team.team.teamLogo,
                  played: team.matchPlayed,
                  won: team.matchWon,
                  drawn: team.matchDrawn,
                  lost: team.matchLost,
                  goalsFor: team.goalsFor,
                  goalsAgainst: team.goalsAgainst,
                  goalDifference: goalDifference,
                  points: team.points,
                  form: team.form,
                );
              }),
            );
          }),

          const SizedBox(height: 20),

          // Player Stats Heading
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Color(0xff1b1b1b),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TOP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SCORER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Top Scorer",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Player Stats Table Header
          const PlayerTableHeader(),

          // Player Stats Data
          Obx(() {
            if (controller.players.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(30),
                child: Text("No player stats available"),
              );
            }

            return Column(
              children: [
                ...List.generate(controller.players.take(5).length, (index) {
                  final stat = controller.players[index];

                  String teamName = stat.team?.teamName ?? "-";
                  String teamLogo = stat.team?.teamLogo ?? "";

                  if (stat.player != null) {
                    final teamId = controller.playerTeamIdMap[stat.player!.id];
                    if (teamId != null) {
                      final pointsTeam = controller.pointsTable
                          .where((p) => p.team.id == teamId)
                          .firstOrNull;
                      if (pointsTeam != null) {
                        teamName = pointsTeam.team.teamName;
                        teamLogo = pointsTeam.team.teamLogo;
                      }
                    }
                  }

                  return PlayerRow(
                    rank: index + 1,
                    playerName: stat.player?.name ?? "Unknown",
                    playerImage: stat.player?.image ?? "",
                    teamName: teamName,
                    teamLogo: teamLogo,
                    // position: stat.position ?? stat.player?.position ?? "-",
                    position:
                        controller.playerPositionMap[stat.player?.id] ??
                        stat.position ??
                        stat.player?.position ??
                        "-",
                    appearance: stat.appearance ?? 0,
                    goals: stat.goals ?? 0,
                  );
                }),
                SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const AllPlayerStats());
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      color: const Color(0xfff1f2f5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text("Team", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("P", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("W", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("D", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("L", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("GF", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("GA", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("GD", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text("PTS", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Form",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamRow({
    required int position,
    required String teamName,
    required String teamLogo,
    required int played,
    required int won,
    required int drawn,
    required int lost,
    required int goalsFor,
    required int goalsAgainst,
    required int goalDifference,
    required int points,
    required String form,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffdddddd))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    "$position",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 38,
                  height: 42,
                  child: teamLogo.isNotEmpty
                      ? Image.network(
                          teamLogo,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.shield, size: 30);
                          },
                        )
                      : const Icon(Icons.shield, size: 30),
                ),

                const SizedBox(width: 5),

                Expanded(
                  child: Text(
                    teamName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: Text("$played")),
          Expanded(child: Text("$won")),
          Expanded(child: Text("$drawn")),
          Expanded(child: Text("$lost")),
          Expanded(child: Text("$goalsFor")),
          Expanded(child: Text("$goalsAgainst")),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
              decoration: BoxDecoration(
                color: goalDifference >= 0
                    ? const Color(0xffd8f8e5)
                    : const Color(0xffffdddd),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                goalDifference >= 0 ? "+$goalDifference" : "$goalDifference",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: goalDifference >= 0 ? Colors.green : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: Text(
              "$points",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: form.split('').take(5).map((result) {
                return Container(
                  margin: const EdgeInsets.only(right: 1),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: result == 'W'
                        ? Colors.green
                        : result == 'L'
                        ? Colors.red
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      result,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Expanded(
          //   flex: 2,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: form.split('').take(5).map((result) {
          //       return Container(
          //         margin: const EdgeInsets.only(right: 2),
          //         width: 14,
          //         height: 14,
          //         decoration: BoxDecoration(
          //           color: result == 'W'
          //               ? Colors.green
          //               : (result == 'L' ? Colors.red : Colors.grey),
          //           shape: BoxShape.circle,
          //         ),
          //         child: Center(
          //           child: Text(
          //             result,
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 8,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
