import 'dart:async';
import 'package:flutter/material.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _content = [
    {
      "line1": "Listen Together.",
      "line2": "Instantly.",
      "body":
          "Start rooms, sync music in real time, and feel every moment together. No delays. No dropouts. Just pure connection.",
    },
    {
      "line1": "Discover People",
      "line2": "On Your Wavelength",
      "body":
          "Discover listeners who match your vibe. Connect through moods, moments, and the music that defines you.",
    },
    {
      "line1": "Your Taste.",
      "line2": "Fully Transparent.",
      "body":
          "See how your taste evolves, tweak what defines you, and stay in control. No hidden algorithms—ever.",
    },
  ];


  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _content.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: _content.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${_content[index]["line1"]!}\n",
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -1.0,

                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: _content[index]["line2"]!,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -1.0,

                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      _content[index]["body"]!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        height: 1.5,
                        color: theme.textTheme.bodyMedium?.color?.withAlpha(
                          180,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _content.length,
            (index) => _buildDot(index, theme),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index, ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 6,
      width: _currentPage == index ? 24 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? theme.colorScheme.secondary
            : theme.colorScheme.secondary.withAlpha(51),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
