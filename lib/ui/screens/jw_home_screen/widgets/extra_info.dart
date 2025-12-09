import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class ExtraInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ExtraInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > JwConstants.TABLET_SIZE;
    final smallScreen = size.width < JwConstants.SMALL_SCREEN;

    return Container(
      decoration: JwStyles.extraInfoBoxDecoration(isDark),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(isTablet ? 10 : 2),
      width: smallScreen ? 95 : 110,
      height: smallScreen ? 105 : 100,
      child: Column(
        children: [
          Icon(icon, size: 26),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: smallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
