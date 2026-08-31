import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AICacheService {
  static const _insightsKey = "cached_ai_insights";
  static const _timeKey = "cached_ai_time";

  Future<void> saveInsights(String json) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_insightsKey, json);
    await prefs.setString(
      _timeKey,
      DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
    );
  }

  Future<String?> loadInsights() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_insightsKey);
  }

  Future<DateTime?> lastUpdated() async {
    final prefs = await SharedPreferences.getInstance();

    final time = prefs.getString(_timeKey);

    if (time == null) return null;

    return DateTime.parse(time);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_insightsKey);
    await prefs.remove(_timeKey);
  }
}
