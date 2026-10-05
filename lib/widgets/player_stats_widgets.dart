import 'package:flutter/material.dart';

class PlayerTableHeader extends StatelessWidget {
  const PlayerTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff1f2f5),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: const Row(
        children: [
          Expanded(flex: 1, child: Text("Rank", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("Player", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("Team", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("Position", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text("Goals", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text("App", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

class PlayerRow extends StatelessWidget {
  final int rank;
  final String playerName;
  final String playerImage;
  final String teamName;
  final String teamLogo;
  final String position;
  final int appearance;
  final int goals;

  const PlayerRow({
    super.key,
    required this.rank,
    required this.playerName,
    required this.playerImage,
    required this.teamName,
    required this.teamLogo,
    required this.position,
    required this.appearance,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffdddddd),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("$rank")),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: playerImage.isNotEmpty
                      ? Image.network(
                          playerImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 20,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person,
                          size: 20,
                        ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    playerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (teamLogo.isNotEmpty)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.network(
                      teamLogo,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.shield, size: 16);
                      },
                    ),
                  ),
                if (teamLogo.isNotEmpty) const SizedBox(width: 4),
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
          Expanded(
            flex: 2,
            child: Text(
              position,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Expanded(flex: 1, child: Text("$goals")),
          Expanded(flex: 1, child: Text("$appearance")),
        ],
      ),
    );
  }
}
