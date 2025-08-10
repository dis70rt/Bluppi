import 'package:bluppi/Data/Models/blup_model.dart';

final List<BlupModel> testBlups = [
  BlupModel(
    id: 'b1',
    user: BlupUser(
      id: 'u_devansh',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Devansh Gupta',
      username: '@FilthyFlirt',
    ),
    content:
        'This track’s got me hotter than a steamy night in. Cranking it up because my vibe’s pure sin. Who’s down to get naughty with this beat?',
    audioUrl: 'https://example.com/audio1.mp3',
    startTime: Duration.zero,
    timestamp: DateTime.now().subtract(Duration(minutes: 2)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b2',
    user: BlupUser(
      id: 'u_sanchit',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Sanchit Kumar',
      username: '@SmuttySeducer',
    ),
    content:
        'Vibing to this like it’s a dirty little secret. Shoving it in your face while I sip something strong and smirk at your tame playlist. Got something filthier?',
    audioUrl: 'https://example.com/audio2.mp3',
    startTime: Duration(seconds: 5),
    timestamp: DateTime.now().subtract(Duration(minutes: 15)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b3',
    user: BlupUser(
      id: 'u_nikshay',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Nikshay Goyal',
      username: '@RaunchyRogue',
    ),
    content:
        'Throwback to this track that’s dirtier than my late-night thoughts. Sharing it because I’m feeling wicked and you’re not ready. Dare to dive into this?',
    audioUrl: 'https://example.com/audio3.mp3',
    startTime: Duration(seconds: 12),
    timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 5)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b4',
    user: BlupUser(
      id: 'u_parth',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Parth Dabas',
      username: '@LustyLad',
    ),
    content:
        'This song’s my alibi for dodging life’s rules. It’s got that naughty edge I’m secretly obsessed with. Who’s ready to get tangled in this sultry rhythm?',
    audioUrl: 'https://example.com/audio4.mp3',
    startTime: Duration.zero,
    timestamp: DateTime.now().subtract(Duration(days: 1, minutes: 10)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b5',
    user: BlupUser(
      id: 'u_naman',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Naman Tandel',
      username: '@SaucyScamp',
    ),
    content:
        'This track’s so filthy it’s burning through my restraint. Dropping it here to drag you into my debauchery. Tag someone who can handle this naughty beat.',
    audioUrl: 'https://example.com/audio5.mp3',
    startTime: Duration(seconds: 3),
    timestamp: DateTime.now().subtract(Duration(hours: 6)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b6',
    user: BlupUser(
      id: 'u_sairaj',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Sairaj Chavan',
      username: '@VulgarVixen',
    ),
    content:
        'Spicing up your feed with this track that’s raunchier than my worst ideas. Sharing it because I’m feeling frisky and you’re caught in the crossfire. What’s your guiltiest jam?',
    audioUrl: 'https://example.com/audio6.mp3',
    startTime: Duration(seconds: 7),
    timestamp: DateTime.now().subtract(Duration(hours: 2, minutes: 30)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),

  BlupModel(
    id: 'b7',
    user: BlupUser(
      id: 'u_hemant',
      profilePic: 'https://avatar.iran.liara.run/public',
      name: 'Hemant Ayuj',
      username: '@RacyRenegade',
    ),
    content:
        'Late-night vibes with this track that’s dirtier than my wildest fantasies. Sharing it so you can drown in this scandalous beat. Who’s up for some reckless fun?',
    audioUrl: 'https://example.com/audio7.mp3',
    startTime: Duration(seconds: 10),
    timestamp: DateTime.now().subtract(Duration(days: 2, hours: 3)),
    audioFrequencies: [
      0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
      0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
      0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
    ],
  ),
];