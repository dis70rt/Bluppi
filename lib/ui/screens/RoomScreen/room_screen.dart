import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms'), centerTitle: true),
      body: Center(
        child: MaterialButton(
          onPressed: () => context.push('/room'),
          color: Colors.pinkAccent,
          child: Text('Create Room'),
        ),
      ),
    );
  }
}
