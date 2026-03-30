import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserNotFoundScreen extends StatelessWidget {
  const UserNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final glassColor = Colors.white.withAlpha(20);
    final activeColor = const Color(0xFF2D3BFF);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: glassColor,
                  border: Border.all(color: Colors.white10, width: 2),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_off_outlined,
                    size: 56,
                    color: Colors.white.withAlpha(150),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                "User Not Found",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                "This account may have been deleted, suspended, or the username is incorrect.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.white.withAlpha(150),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                height: 44,
                width: 200,
                child: MaterialButton(
                  onPressed: () => context.pushReplacement('/'),
                  color: activeColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Go Back",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
