import 'package:flutter/material.dart';

Widget editRow() {
  return Center(
    child: MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.white30, width: 1),
        ),
        child: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}