import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/following_stats.dart';
import 'package:synqit/Utils/snackbar.dart';

class FollowButton extends ConsumerStatefulWidget {
  final String followeeId;
  const FollowButton({super.key, required this.followeeId});

  @override
  ConsumerState<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<FollowButton> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool? _followStatus;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fetchFollowStatus();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchFollowStatus() async {
    try {
      final status =
          await ref.read(userProvider.notifier).isFollowing(widget.followeeId);
      if (mounted) {
        setState(() {
          _followStatus = status;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _followStatus = false;
        });
      }
    }
  }

  Future<void> _toggleFollowStatus() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _animationController.forward().then((_) => _animationController.reverse());
    final previousState = _followStatus;

    try {
      setState(() {
        _followStatus = !(_followStatus ?? false);
      });

      if (previousState == true) {
        await ref
            .read(userProvider.notifier)
            .decrementFollowing(widget.followeeId);
        ref
            .read(followStatsProvider(widget.followeeId).notifier)
            .decrementFollowers();
      } else {
        await ref
            .read(userProvider.notifier)
            .incrementFollowing(widget.followeeId);
        ref
            .read(followStatsProvider(widget.followeeId).notifier)
            .incrementFollowers();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _followStatus = previousState;
        });

        String errorMessage = "Error updating follow status";

        if (e.toString().contains("Already following")) {
          errorMessage = "You're already following this user";
          setState(() {
            _followStatus = true;
          });
        } else if (e.toString().contains("not following")) {
          errorMessage = "You're not following this user";
          setState(() {
            _followStatus = false;
          });
        }

        showSnackBar(
          context: context,
          message: errorMessage,
          icon: const FaIcon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircularButton(Icons.chat_outlined),
        const SizedBox(width: 18),
        _buildFollowButton(),
        const SizedBox(width: 18),
        _buildCircularButton(Icons.share),
      ],
    );
  }
  
  Widget _buildCircularButton(IconData icon) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: FaIcon(icon, size: 18),
        ),
      ),
    );
  }

  Widget _buildFollowButton() {
    final isFollowing = _followStatus ?? false;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Center(
        child: MaterialButton(
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
          onPressed: _isLoading ? null : _toggleFollowStatus,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            decoration: BoxDecoration(
              border: Border.all(
                color: isFollowing ? AppColors.accent : Colors.transparent,
                width: isFollowing ? 1 : 0,
              ),
              color: isFollowing ? AppColors.background : AppColors.accent,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isFollowing ? AppColors.accent : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Text(isFollowing ? "Following" : "Follow"),
                ),
          ),
        ),
      ),
    );
  }
}