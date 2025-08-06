import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'language_provider.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'khitma_screen.dart';
import 'dhikr_screen.dart';
import 'bottom_nav_bar.dart';
import 'dhikr_newgroup_screen.dart';

class DhikrGroupScreen extends StatefulWidget {
  const DhikrGroupScreen({super.key});

  @override
  State<DhikrGroupScreen> createState() => _DhikrGroupScreenState();
}

class _DhikrGroupScreenState extends State<DhikrGroupScreen> {
  int _selectedIndex = 1;
  int _selectedTab = 0; // 0 for Joined, 1 for Explore

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DhikrScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const KhitmaScreen()),
          );
          break;
        case 3:
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        final isArabic = languageProvider.isArabic;
        final amiriFont = isArabic ? 'Amiri' : null;
        final isLightMode = !themeProvider.isDarkMode;
        final greenColor = const Color(0xFF205C3B);
        final creamColor = const Color(0xFFF7F3E8);

        return Directionality(
          textDirection: languageProvider.textDirection,
          child: Scaffold(
            backgroundColor: isLightMode
                ? Colors.white
                : themeProvider.backgroundColor,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Stack(
              children: [
                // Background images covering entire screen
                // Background image for both themes
                Positioned.fill(
                  child: Opacity(
                    opacity: !isLightMode ? 0.5 : 1.0,
                    child: Image.asset(
                      themeProvider.backgroundImage3,
                      fit: BoxFit.cover,
                      cacheWidth: 800,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
                // Color overlay for dark mode only
                if (!isLightMode)
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.2)),
                  ),
                // Main content with SafeArea
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: isLightMode ? greenColor : creamColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: Text(
                                isArabic ? 'مجموعات الذكر' : 'Dhikr Groups',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isLightMode ? greenColor : creamColor,
                                  fontFamily: amiriFont,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DhikrNewGroupScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: isLightMode
                                        ? greenColor
                                        : creamColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    isArabic ? 'إضافة جديد' : 'Add New',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isLightMode
                                          ? greenColor
                                          : creamColor,
                                      fontFamily: amiriFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Tab buttons
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isLightMode
                                ? const Color(0xFFE8E8E8)
                                : const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTab = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedTab == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: _selectedTab == 0
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      isArabic ? 'منضم' : 'Joined',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedTab == 0
                                            ? const Color(0xFF2D2D2D)
                                            : (isLightMode
                                                  ? Colors.grey[600]
                                                  : Colors.grey[400]),
                                        fontFamily: amiriFont,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTab = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedTab == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: _selectedTab == 1
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      isArabic ? 'استكشاف' : 'Explore',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedTab == 1
                                            ? const Color(0xFF2D2D2D)
                                            : (isLightMode
                                                  ? Colors.grey[600]
                                                  : Colors.grey[400]),
                                        fontFamily: amiriFont,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Empty space for future content
                        Expanded(
                          child: Container(
                            // Empty container for future content
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        );
      },
    );
  }
}
