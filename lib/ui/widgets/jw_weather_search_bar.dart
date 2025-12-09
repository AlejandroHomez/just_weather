import 'dart:async';
import 'package:flutter/material.dart';

class JwWeatherSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const JwWeatherSearchBar({super.key, required this.onSearch});

  @override
  State<JwWeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<JwWeatherSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onSearch(value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      onChanged: _onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset("assets/logo.png", height: 20),
        ),
        hintText: "Buscar ciudad",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
