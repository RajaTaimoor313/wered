import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart';
import 'theme_provider.dart';
import 'language_provider.dart';
import 'app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // Add navigation logic here
      switch (index) {
        case 0:
          // Already on home
          break;
        case 1:
          // Navigate to Dhikr screen
          break;
        case 2:
          // Navigate to Khitma screen
          break;
        case 3:
          // Navigate to Groups screen
          break;
        case 4:
          // Navigate to Profile screen
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
        
        return Directionality(
          textDirection: languageProvider.textDirection,
          child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: themeProvider.gradientColors,
                ),
              ),
              child: Stack(
                children: [
                  // Background image with optimized loading (always visible)
                  Positioned.fill(
                    child: Image.asset(
                      'assets/background_elements/3_background.png',
            fit: BoxFit.cover,
                      cacheWidth: 800, // Optimize memory usage
                      filterQuality: FilterQuality.medium, // Balance quality and performance
                    ),
                  ),
                  // Color overlay based on theme
                  Positioned.fill(
                    child: Container(
                      color: themeProvider.backgroundImageOverlay,
                    ),
                  ),
                  // Main content
                  SafeArea(
          child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                            const SizedBox(height: 25),
                // Profile & Notification
                            _ProfileSection(),
                            const SizedBox(height: 20),
                            // Overall Progress
                            _ProgressSection(),
                            const SizedBox(height: 20),
                            // Current Streak
                            _StreakSection(),
                            const SizedBox(height: 20),
                            // Motivational Verse
                            _MotivationalVerseSection(),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _BottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        );
      },
    );
  }
}

// Optimized Profile Section
class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeProvider.cardBackgroundColor,
                      border: Border.all(color: themeProvider.borderColor, width: 2),
                    ),
                    child: Icon(
                      Icons.person,
                      color: themeProvider.primaryTextColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  appLocalizations.salaamAli,
                  style: TextStyle(
                    color: themeProvider.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeProvider.cardBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.notifications_none,
                color: themeProvider.primaryTextColor,
                size: 24,
              ),
            ),
          ],
        );
      },
    );
  }
}

// Optimized Progress Section
class _ProgressSection extends StatelessWidget {
  const _ProgressSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.overallProgress,
              style: TextStyle(
                color: themeProvider.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                  child: _ProgressCard(
                    title: appLocalizations.dhikrGoal,
                    progress: 0.5,
                    subtitle: appLocalizations.dhikrOutOf,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ProgressCard(
                    title: appLocalizations.khitmaGoal,
                        progress: 0.5,
                    subtitle: appLocalizations.juzzOutOf,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Optimized Progress Card
class _ProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final String subtitle;

  const _ProgressCard({
    required this.title,
    required this.progress,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeProvider.cardBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: themeProvider.borderColor),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: themeProvider.secondaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                width: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(themeProvider.primaryTextColor),
                      backgroundColor: themeProvider.borderColor,
                    ),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        color: themeProvider.primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: TextStyle(
                  color: themeProvider.primaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Optimized Streak Section
class _StreakSection extends StatelessWidget {
  const _StreakSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.currentStreak,
              style: TextStyle(
                color: themeProvider.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
                Container(
              padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                color: themeProvider.cardBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: themeProvider.borderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.yourCurrentStreak,
                            style: TextStyle(
                              color: themeProvider.secondaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            appLocalizations.days,
                            style: TextStyle(
                              color: themeProvider.primaryTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/background_elements/4.png',
                        width: 60,
                        height: 60,
                    cacheWidth: 120, // Optimize memory usage
                    filterQuality: FilterQuality.medium,
                      ),
                    ],
                  ),
                ),
          ],
        );
      },
    );
  }
}

// Optimized Motivational Verse Section
class _MotivationalVerseSection extends StatelessWidget {
  const _MotivationalVerseSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.motivationalVerse,
              style: TextStyle(
                color: themeProvider.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
                Container(
                  width: double.infinity,
              padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? const Color(0xFFF5F5DC) : const Color(0xFF2D1B69),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Decorative corner elements
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                      Text(
                    appLocalizations.verseText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                      color: themeProvider.isDarkMode ? const Color(0xFF2D1B69) : Colors.white,
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Decorative line with diamond
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appLocalizations.surahAnNahl,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "(16:128)",
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? const Color(0xFF8B4513) : Colors.white,
                      fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ],
        );
      },
    );
  }
}

// Optimized Bottom Navigation Bar
class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const _BottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Container(
          decoration: BoxDecoration(
            color: themeProvider.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home,
                    label: appLocalizations.home,
                    isSelected: selectedIndex == 0,
                    onTap: () => onItemTapped(0),
                  ),
                  _NavItem(
                    icon: Icons.favorite,
                    label: appLocalizations.dhikr,
                    isSelected: selectedIndex == 1,
                    onTap: () => onItemTapped(1),
                  ),
                  _NavItem(
                    icon: Icons.menu_book,
                    label: appLocalizations.khitma,
                    isSelected: selectedIndex == 2,
                    onTap: () => onItemTapped(2),
                  ),
                  _NavItem(
                    icon: Icons.group,
                    label: appLocalizations.groups,
                    isSelected: selectedIndex == 3,
                    onTap: () => onItemTapped(3),
                  ),
                  _NavItem(
                    icon: Icons.person,
                    label: appLocalizations.profile,
                    isSelected: selectedIndex == 4,
                    onTap: () => onItemTapped(4),
          ),
        ],
      ),
            ),
          ),
        );
      },
    );
  }
}

// Optimized Navigation Item
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final selectedColor = themeProvider.primaryTextColor;
        final unselectedColor = themeProvider.secondaryTextColor;
        
        return GestureDetector(
          onTap: onTap,
      child: Column(
            mainAxisSize: MainAxisSize.min,
        children: [
              Icon(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 24,
              ),
              const SizedBox(height: 4),
          Text(
                label,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
