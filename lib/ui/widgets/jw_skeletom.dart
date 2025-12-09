import 'package:flutter/material.dart';
import 'package:just_weather_app/config/theme/jw_colors.dart';

class JwHomeSkeleton extends StatefulWidget {
  const JwHomeSkeleton({super.key});

  @override
  _JwHomeSkeletonState createState() => _JwHomeSkeletonState();
}

class _JwHomeSkeletonState extends State<JwHomeSkeleton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? JwColors.JW_PRIMARY_BLACK
          : JwColors.JW_PRIMARY_WHITE,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletomBox(
                  opacityAnimation: _opacityAnimation,
                  height: 32,
                  width: 140,
                ),
                const SizedBox(height: 8),
                _SkeletomBox(
                  opacityAnimation: _opacityAnimation,
                  height: 18,
                  width: 100,
                ),

                const SizedBox(height: 30),

                Center(
                  child: Column(
                    children: [
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(height: 20),
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 80,
                        width: 160,
                      ),
                      const SizedBox(height: 10),
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 20,
                        width: 90,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                _SkeletomBox(
                  opacityAnimation: _opacityAnimation,
                  height: 22,
                  width: 180,
                ),

                const SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? JwColors.JW_SEQUENTIAL_BLACK_700
                        : JwColors.JW_PRIMARY_WHITE,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                          _SkeletomBox(
                            opacityAnimation: _opacityAnimation,
                            height: 50,
                            width: 70,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                _SkeletomBox(
                  opacityAnimation: _opacityAnimation,
                  height: 22,
                  width: 180,
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 130,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 120,
                        width: 80,
                      ),
                      const SizedBox(width: 12),
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 120,
                        width: 80,
                      ),
                      const SizedBox(width: 12),
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 120,
                        width: 80,
                      ),
                      const SizedBox(width: 12),
                      _SkeletomBox(
                        opacityAnimation: _opacityAnimation,
                        height: 120,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletomBox extends StatelessWidget {
  const _SkeletomBox({
    required Animation<double> opacityAnimation,
    required this.height,
    required this.width,
  }) : _opacityAnimation = opacityAnimation;

  final Animation<double> _opacityAnimation;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: JwColors.JW_SEQUENTIAL_BLACK_100,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
