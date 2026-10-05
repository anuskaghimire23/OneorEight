import 'package:flutter/material.dart';
import 'package:football/controller/home_controller.dart';
import 'package:football/widgets/player_stats_widgets.dart';
import 'package:get/get.dart';

class AllPlayerStats extends GetView<HomeController> {
  const AllPlayerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("All Player Stats")),
      body: Obx(() {
        if (controller.players.isEmpty) {
          return const Center(child: Text("No player stats available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Black heading - same as League Standings
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ALL",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "PLAYER STATS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "All player statistics",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Player table header
              const PlayerTableHeader(),

              // ALL players
              ...List.generate(controller.players.length, (index) {
                final stat = controller.players[index];

                String teamName = stat.team?.teamName ?? "-";
                String teamLogo = stat.team?.teamLogo ?? "";

                // Get team information from points table
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
                  position:
                      controller.playerPositionMap[stat.player?.id] ??
                      stat.position ??
                      stat.player?.position ??
                      "-",
                  appearance: stat.appearance ?? 0,
                  goals: stat.goals ?? 0,
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
