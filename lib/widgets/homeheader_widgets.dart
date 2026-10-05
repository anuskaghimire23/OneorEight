import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 82,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // NSFL Logo
                  Container(
                    width: 42,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffff0080),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "NSFL",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Name and tagline
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Nepal School Football League",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "WHERE TALENT MEETS OPPORTUNITY",
                          style: TextStyle(
                            color: Color(0xffff0080),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu
                  const Icon(Icons.menu, color: Colors.white, size: 30),
                ],
              ),
            ),
          ),

          // Pink line
          Container(height: 2, color: const Color(0xffff0080)),
        ],
      ),
    );
  }
}
