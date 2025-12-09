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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? JwColors.JW_PRIMARY_BLACK : JwColors.JW_PRIMARY_WHITE,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? JwColors.JW_SCALE_PRIMARY
                : JwColors.JW_PRIMARY_GREY,
            offset: Offset(-6, -6),
            blurRadius: 16,
          ),

          BoxShadow(
            color: isDark
                ? JwColors.JW_PRIMARY_BLACK_600
                : JwColors.JW_PRIMARY_GREY_600,
            offset: Offset(6, 6),
            blurRadius: 16,
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      width: 110,
      height: 100,
      child: Column(
        children: [
          Icon(icon, size: 26),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
