import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget followRow() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white12,

            // width: 1,/
          ),
        ),
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const FaIcon(Icons.chat_outlined, size: 18),
          ),
        ),
      ),
      const SizedBox(width: 18),
      Center(
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            decoration: const BoxDecoration(
                color: Color(0xff3a71fa),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: const Text(
              "Follow",
              style: TextStyle(),
            ),
          ),
        ),
      ),
      const SizedBox(width: 18),
      Container(
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white12,

            // width: 1,/
          ),
        ),
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const FaIcon(Icons.share, size: 18),
          ),
        ),
      ),
    ],
  );
}
