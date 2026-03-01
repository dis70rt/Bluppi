import 'package:flutter/material.dart';

class LiveChatFeed extends StatelessWidget {
  const LiveChatFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyChats = [
      {'sender': 'Alex', 'message': 'This transition was so smooth 🔥', 'color': Colors.blueAccent},
      {'sender': 'Sarah', 'message': 'Can we queue up some synthwave next?', 'color': Colors.pinkAccent},
      {'sender': 'Mike', 'message': 'Who is the original artist for this remix?', 'color': Colors.tealAccent},
      {'sender': 'Elena', 'message': 'Loving the vibes in here ✨', 'color': Colors.amberAccent},
      {'sender': 'Chris', 'message': 'Volume up!! 🔊', 'color': Colors.purpleAccent},
      {'sender': 'Jordan', 'message': 'Hello from Tokyo! 🇯🇵', 'color': Colors.greenAccent},
    ].reversed.toList();

    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.15, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          itemCount: dummyChats.length,
          itemBuilder: (context, index) {
            final chat = dummyChats[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${chat['sender']}   ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: chat['color'],
                        fontSize: 14,
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha(150),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    TextSpan(
                      text: chat['message'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha(150),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}