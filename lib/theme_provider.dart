import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true; // Start with dark mode
  String _currentLanguage = 'en'; // Start with English

  bool get isDarkMode => _isDarkMode;
  String get currentLanguage => _currentLanguage;

  ThemeProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _currentLanguage = prefs.getString('currentLanguage') ?? 'en';
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('currentLanguage', _currentLanguage);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveSettings();
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    _saveSettings();
    notifyListeners();
  }

  void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
    _saveSettings();
    notifyListeners();
  }

  Future<void> logout() async {
    // Clear any user-specific data but keep theme/language preferences
    // Keep theme and language settings, clear other user data if needed
    // await prefs.remove('userToken'); // Example of clearing user data
  }

  // Theme colors
  Color get primaryColor => _isDarkMode ? const Color(0xFF2D1B69) : Colors.white;
  Color get secondaryColor => _isDarkMode ? const Color(0xFF6B46C1) : const Color(0xFFF8F9FA);
  Color get tertiaryColor => _isDarkMode ? const Color(0xFF8B5CF6) : const Color(0xFFE9ECEF);
  
  // Text colors
  Color get primaryTextColor => _isDarkMode ? Colors.white : const Color(0xFF2D1B69);
  Color get secondaryTextColor => _isDarkMode ? Colors.white70 : Colors.black87;
  Color get accentTextColor => _isDarkMode ? Colors.white : const Color(0xFF2D1B69);
  
  // Background colors
  Color get backgroundColor => _isDarkMode ? const Color(0xFF2D1B69) : Colors.white;
  Color get cardBackgroundColor => _isDarkMode ? Colors.white.withOpacity(0.1) : const Color(0xFF2D1B69).withOpacity(0.1);
  Color get borderColor => _isDarkMode ? Colors.white.withOpacity(0.2) : const Color(0xFF2D1B69).withOpacity(0.2);
  
  // Gradient colors
  List<Color> get gradientColors => _isDarkMode 
    ? [const Color(0xFF2D1B69), const Color(0xFF6B46C1), const Color(0xFF8B5CF6)]
    : [Colors.white, const Color(0xFFF8F9FA), const Color(0xFFE9ECEF)];

  // Background image overlay colors
  Color get backgroundImageOverlay => _isDarkMode 
    ? const Color(0xFF2D1B69).withOpacity(0.7) // Purple overlay for dark mode
    : Colors.transparent; // No overlay for light mode

  // Background image paths
  String get backgroundImage1 => _isDarkMode ? 'assets/background_elements/1.png' : 'assets/background_elements/1_LE.png';
  String get backgroundImage2 => _isDarkMode ? 'assets/background_elements/2.png' : 'assets/background_elements/2_LE.png';
  String get backgroundImage3 => 'assets/background_elements/3_background.png'; // Same for both themes

  // Switch colors
  Color get switchActiveColor => _isDarkMode ? Colors.white : const Color(0xFF2D1B69);
  Color get switchActiveTrackColor => _isDarkMode ? Colors.white.withOpacity(0.3) : const Color(0xFF2D1B69).withOpacity(0.3);
  Color get switchInactiveThumbColor => _isDarkMode ? Colors.white : const Color(0xFF2D1B69);
  Color get switchInactiveTrackColor => _isDarkMode ? Colors.white.withOpacity(0.2) : const Color(0xFF2D1B69).withOpacity(0.2);
} 