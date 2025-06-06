import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';

enum ThemeType {
  avengersEndgame,
  monochrome
  // love,
}

class ChatThemeState {
  final ThemeType themeType;
  final Map<ThemeType, ThemeConfiguration> _themeConfigurations;

  ChatThemeState({required this.themeType}) : _themeConfigurations = {
    ThemeType.monochrome: ThemeConfiguration(
      name: 'Monochrome',
      backgroundImage: 'assets/images/avengers_endgame.jpg',
      background: AppColors.backgroundDark,
      userBubble: Colors.grey.shade700,
      receivedBubble: const Color(0xFF2C2C2E),
      userText: Colors.white,
      receivedText: Colors.white,
      timestamp: Colors.white54,
      receivedTimestamp: Colors.white70,
      sendButton: Colors.grey.shade700,
      themeIcon: Colors.grey,
      appBarBackground: AppColors.backgroundDark,
      appBarText: Colors.white,
      appBarIconColor: Colors.white,
    ),
    ThemeType.avengersEndgame: ThemeConfiguration(
      name: 'Avenger\'s Endgame',
      backgroundImage: 'assets/images/avengers_endgame.jpg',
      background: Colors.transparent,
      userBubble: Colors.indigoAccent.shade100,
      receivedBubble: const Color(0xFF2C2C2E),
      userText: Colors.black,
      receivedText: Colors.white,
      timestamp: Colors.black54,
      receivedTimestamp: Colors.white70,
      sendButton: Colors.indigoAccent.shade100,
      themeIcon: Colors.indigoAccent.shade100,
      appBarBackground: AppColors.backgroundDark,
      appBarText: Colors.white,
      appBarIconColor: Colors.white,
    ),
    // ThemeType.love: ThemeConfiguration(
    //   name: 'Love',
    //   backgroundImage: 'assets/images/love.jpg',
    //   background: Colors.transparent,
    //   userBubble: Colors.pinkAccent.shade200,
    //   receivedBubble: Colors.pink.shade50,
    //   userText: Colors.pink.shade50,
    //   receivedText: Colors.pinkAccent.shade400,
    //   timestamp: Colors.pink.shade50,
    //   receivedTimestamp: Colors.pinkAccent.shade400,
    //   sendButton: Colors.pinkAccent,
    //   themeIcon: Colors.pinkAccent,
    //   appBarBackground: const Color(0xFF880E4F),
    //   appBarText: Colors.white,
    //   appBarIconColor: Colors.white,
    // ),
  };

  ThemeConfiguration get currentTheme => _themeConfigurations[themeType]!;

  String get themeName => currentTheme.name;
  String get backgroundImage => currentTheme.backgroundImage;
  Color get background => currentTheme.background;
  Color get userBubble => currentTheme.userBubble;
  Color get receivedBubble => currentTheme.receivedBubble;
  Color get userText => currentTheme.userText;
  Color get receivedText => currentTheme.receivedText;
  Color get timestamp => currentTheme.timestamp;
  Color get receivedTimestamp => currentTheme.receivedTimestamp;
  Color get sendButton => currentTheme.sendButton;
  Color get themeIcon => currentTheme.themeIcon;
  Color get appBarBackground => currentTheme.appBarBackground;
  Color get appBarText => currentTheme.appBarText;
  Color get appBarIconColor => currentTheme.appBarIconColor;

  static const Color inputBackground = Color(0xFF1A1A1A);
  static const Color inputText = Colors.white;
  static const Color inputHint = Colors.grey;

  ChatThemeState copyWith({ThemeType? themeType}) {
    return ChatThemeState(
      themeType: themeType ?? this.themeType,
    );
  }
  
  // Get all available themes
  List<ThemeType> get availableThemes => _themeConfigurations.keys.toList();
  
  // Get theme names map for UI
  Map<ThemeType, String> get themeNames => 
      {for (var entry in _themeConfigurations.entries) entry.key: entry.value.name};
}

class ThemeConfiguration {
  final String name;
  final String backgroundImage;
  final Color background;
  final Color userBubble;
  final Color receivedBubble;
  final Color userText;
  final Color receivedText;
  final Color timestamp;
  final Color receivedTimestamp;
  final Color sendButton;
  final Color themeIcon;
  final Color appBarBackground;
  final Color appBarText;
  final Color appBarIconColor;

  const ThemeConfiguration({
    required this.name,
    required this.backgroundImage,
    required this.background,
    required this.userBubble,
    required this.receivedBubble,
    required this.userText,
    required this.receivedText,
    required this.timestamp,
    required this.receivedTimestamp,
    required this.sendButton,
    required this.themeIcon,
    required this.appBarBackground,
    required this.appBarText,
    required this.appBarIconColor,
  });
}

class ChatThemeNotifier extends StateNotifier<ChatThemeState> {
  ChatThemeNotifier() : super(ChatThemeState(themeType: ThemeType.avengersEndgame));

  void setTheme(ThemeType themeType) {
    state = state.copyWith(themeType: themeType);
  }
}

final chatThemeProvider =
    StateNotifierProvider.family<ChatThemeNotifier, ChatThemeState, String>(
  (ref, conversationId) => ChatThemeNotifier(),
);