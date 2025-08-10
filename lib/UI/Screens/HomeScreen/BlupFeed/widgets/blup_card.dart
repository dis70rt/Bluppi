import 'package:bluppi/Data/Models/blup_model.dart';
import 'package:bluppi/UI/Screens/HomeScreen/BlupFeed/widgets/action_widgets.dart';
import 'package:bluppi/UI/Screens/HomeScreen/BlupFeed/widgets/blup_freq.dart';
import 'package:bluppi/UI/Screens/HomeScreen/BlupFeed/widgets/curve_line_painter.dart';
import 'package:flutter/material.dart';

class BlupCard extends StatefulWidget {
  final BlupModel blup;

  const BlupCard({super.key, required this.blup});

  @override
  State<BlupCard> createState() => _BlupCardState();
}

class _BlupCardState extends State<BlupCard> {
  final GlobalKey _avatarKey = GlobalKey();
  final GlobalKey _freqKey = GlobalKey();
  double targetY = 70;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
    super.initState();
  }

  void _measure() {
    final freqBox = _freqKey.currentContext?.findRenderObject() as RenderBox?;
    final avatarBox =
        _avatarKey.currentContext?.findRenderObject() as RenderBox?;
    if (freqBox == null || avatarBox == null) return;

    final freqCenterGlobal = freqBox.localToGlobal(
      Offset(freqBox.size.width / 2, freqBox.size.height / 2),
    );

    final avatarTopGlobal = avatarBox.localToGlobal(Offset.zero);
    final avatarBottomGlobal =
        avatarTopGlobal + Offset(0, avatarBox.size.height);

    final double newTargetY = freqCenterGlobal.dy - avatarBottomGlobal.dy;

    final double safeTargetY = newTargetY.clamp(8.0, 2000.0);
    if ((targetY - safeTargetY).abs() > 0.5 && mounted) {
      setState(() => targetY = safeTargetY);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 40;
    const double padding = 0;
    final List<double> freqs = widget.blup.audioFrequencies;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAvatar(_avatarKey, avatarSize),
                  CustomPaint(
                    size: Size(0, targetY),
                    painter: CurvedLinePainter(curveTargetY: targetY),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        widget.blup.user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        widget.blup.user.username,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (widget.blup.content.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, left: 12),
                        child: Text(widget.blup.content,
                            style: const TextStyle(fontSize: 15)),
                      ),
                    BlupFreqWidget(key: _freqKey, freqs: freqs),
                    BlupEngagement(
                        likesCount: widget.blup.likesCount,
                        commentsCount: widget.blup.commentsCount,
                        shareCount: widget.blup.shareCount),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildAvatar(GlobalKey key, double avatarSize) {
    if (widget.blup.user.profilePic != null) {
      return ClipRRect(
        key: key,
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: Image.network(
          widget.blup.user.profilePic!,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return CircleAvatar(
        key: key,
        radius: avatarSize / 2,
        backgroundColor: Colors.grey.shade300,
        child: Icon(
          Icons.person,
          size: avatarSize * 0.6,
          color: Colors.grey.shade600,
        ),
      );
    }
  }
}
