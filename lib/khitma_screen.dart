import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'language_provider.dart';
import 'home_screen.dart' show HomeScreen;
import 'profile_screen.dart';
import 'bottom_nav_bar.dart';

class KhitmaScreen extends StatefulWidget {
  const KhitmaScreen({super.key});

  @override
  State<KhitmaScreen> createState() => _KhitmaScreenState();
}

class _KhitmaScreenState extends State<KhitmaScreen> {
  int _selectedIndex = 2; // Khitma is selected

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
          // Navigate to Dhikr screen
          break;
        case 2:
          // Already on Khitma
          break;
        case 3:
          // Navigate to Groups screen
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
        final mediaQuery = MediaQuery.of(context);
        return Directionality(
          textDirection: languageProvider.textDirection,
          child: Scaffold(
            backgroundColor: themeProvider.backgroundColor,
            body: Stack(
              children: [
                // Full-page background image
                Positioned.fill(
                  child: Image.asset(
                    'assets/background_elements/5.png',
                    fit: BoxFit.cover,
                    cacheWidth: 800,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
                // Color overlay (optional, for theme)
                Positioned.fill(
                  child: Container(color: themeProvider.backgroundImageOverlay),
                ),
                // Header (back button and title) over image
                Positioned(
                  top: mediaQuery.padding.top + 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          languageProvider.isArabic ? 'الختمة' : 'Khitma',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // To balance the back button
                    ],
                  ),
                ),
                // const SizedBox(height: 10), // Space for header
                // Rounded box overlapping image
                Positioned(
                  left: 0,
                  right: 0,
                  top: mediaQuery.size.height * 0.32,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                    decoration: BoxDecoration(
                      color: themeProvider.secondaryColor.withOpacity(0.98),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          languageProvider.isArabic ? 'الختمة' : 'Khitma',
                          style: TextStyle(
                            color: themeProvider.primaryTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          languageProvider.isArabic
                              ? 'ابدأ رحلتك الروحية بسهولة — ابدأ ختمة جديدة، أكمل وردك اليومي، أو انضم إلى مجموعة لتلاوة جماعية.'
                              : 'Begin your spiritual journey with ease — start a new Khitma, complete your daily Werd, or join a group to recite together.',
                          style: TextStyle(
                            color: themeProvider.secondaryTextColor,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Buttons
                        Column(
                          children: [
                            // New Khitma button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5E6D3),
                                  foregroundColor: const Color(0xFF2D1B3D),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  languageProvider.isArabic
                                      ? 'ختمة جديدة'
                                      : 'New Khitma',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Start Daily Werd button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: themeProvider.secondaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  languageProvider.isArabic
                                      ? 'ابدأ الورد اليومي'
                                      : 'Start Daily Wered',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: themeProvider.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Khitma Groups button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      themeProvider.primaryTextColor,
                                  side: BorderSide(
                                    color: themeProvider.primaryTextColor
                                        .withOpacity(0.54),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  languageProvider.isArabic
                                      ? 'مجموعات الختمة'
                                      : 'Khitma Groups',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: themeProvider.primaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
