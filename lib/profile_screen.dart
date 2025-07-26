import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'theme_provider.dart';
import 'language_provider.dart';
import 'app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4; // Profile is selected

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // Add navigation logic here
      switch (index) {
        case 0:
          // Navigate to Home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
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
          // Already on Profile
          break;
      }
    }
  }

  void _showLanguageDialog(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.chooseLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(appLocalizations.english),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: languageProvider.currentLocale.languageCode,
                  onChanged: (value) {
                    languageProvider.setLanguage(value!);
                    themeProvider.setLanguage(value);
                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  languageProvider.setLanguage('en');
                  themeProvider.setLanguage('en');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.arabic),
                leading: Radio<String>(
                  value: 'ar',
                  groupValue: languageProvider.currentLocale.languageCode,
                  onChanged: (value) {
                    languageProvider.setLanguage(value!);
                    themeProvider.setLanguage(value);
                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  languageProvider.setLanguage('ar');
                  themeProvider.setLanguage('ar');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleLogout(BuildContext context) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;

    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.logout),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                appLocalizations.logout,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Perform logout
      await themeProvider.logout();
      
      // Navigate to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Remove all previous routes
      );
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
                      themeProvider.backgroundImage3,
                      fit: BoxFit.cover,
                      cacheWidth: 800,
                      filterQuality: FilterQuality.medium,
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
                            const SizedBox(height: 20),
                            // Header with Back Button and Title
                            _HeaderWithBackButton(),
                            const SizedBox(height: 10),
                            // Profile Header
                            _ProfileHeader(),
                            const SizedBox(height: 10),
                            // Content Sections
                            _ContentSections(
                              onLanguageTap: _showLanguageDialog,
                              onLogoutTap: _handleLogout,
                            ),
                            const SizedBox(height: 20),
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

// Header with Back Button and Title
class _HeaderWithBackButton extends StatelessWidget {
  const _HeaderWithBackButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Row(
          children: [
            // Back Button
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeProvider.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: themeProvider.primaryTextColor,
                  size: 20,
                ),
              ),
            ),
            // Centered Title
            Expanded(
              child: Center(
                child: Text(
                  appLocalizations.profile,
                  style: TextStyle(
                    color: themeProvider.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Empty space to balance the back button
            SizedBox(
              width: 44,
              height: 44,
            ),
          ],
        );
      },
    );
  }
}

// Optimized Profile Header
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Center(
          child: Column(
            children: [
              // Profile Picture
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: themeProvider.borderColor, width: 3),
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.cardBackgroundColor,
                    ),
                    child: Icon(
                      Icons.person,
                      color: themeProvider.primaryTextColor,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name
              const Text(
                "Ali Shahwaiz",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Optimized Content Sections
class _ContentSections extends StatelessWidget {
  final Function(BuildContext) onLanguageTap;
  final Function(BuildContext) onLogoutTap;

  const _ContentSections({
    required this.onLanguageTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appLocalizations = AppLocalizations.of(context)!;
        
        return Column(
          children: [
            // Account Info Section
            _SectionCard(
              title: appLocalizations.accountInfo,
              items: [
                _SectionItem(
                  icon: Icons.person,
                  title: appLocalizations.accountDetails,
                  onTap: () {},
                ),
                _SectionItem(
                  icon: Icons.edit,
                  title: appLocalizations.editProfile,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Language & Display Section
            _SectionCard(
              title: appLocalizations.languageAndDisplay,
              items: [
                _SectionItem(
                  icon: Icons.language,
                  title: appLocalizations.chooseLanguage,
                  onTap: () => onLanguageTap(context),
                ),
                _SectionItem(
                  icon: Icons.dark_mode,
                  title: themeProvider.isDarkMode ? appLocalizations.lightMode : appLocalizations.darkMode,
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.setTheme(value);
                    },
                    activeColor: themeProvider.switchActiveColor,
                    activeTrackColor: themeProvider.switchActiveTrackColor,
                    inactiveThumbColor: themeProvider.switchInactiveThumbColor,
                    inactiveTrackColor: themeProvider.switchInactiveTrackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Reminder Preference Section
            _SectionCard(
              title: appLocalizations.reminderPreference,
              items: [
                _SectionItem(
                  icon: Icons.notifications,
                  title: appLocalizations.dhikrReminder,
                  onTap: () {},
                ),
                _SectionItem(
                  icon: Icons.settings,
                  title: appLocalizations.reminderSettings,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Group Management Section
            _SectionCard(
              title: appLocalizations.groupManagement,
              items: [
                _SectionItem(
                  icon: Icons.group,
                  title: appLocalizations.groups,
                  onTap: () {},
                ),
                _SectionItem(
                  icon: Icons.privacy_tip,
                  title: appLocalizations.privacyAndNotification,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Account Control Section
            _SectionCard(
              title: appLocalizations.accountControl,
              items: [
                _SectionItem(
                  icon: Icons.person_remove,
                  title: appLocalizations.accountDeletionRequest,
                  onTap: () {},
                ),
                _SectionItem(
                  icon: Icons.logout,
                  title: appLocalizations.logout,
                  onTap: () => onLogoutTap(context),
                  textColor: Colors.red,
                  iconColor: Colors.red,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Optimized Section Card
class _SectionCard extends StatelessWidget {
  final String title;
  final List<_SectionItem> items;

  const _SectionCard({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: themeProvider.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: themeProvider.cardBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: themeProvider.borderColor),
              ),
              child: Column(
                children: items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    children: [
                      item,
                      if (index < items.length - 1)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 1,
                          color: themeProvider.borderColor,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Optimized Section Item
class _SectionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;
  final Widget? trailing;

  const _SectionItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor ?? themeProvider.primaryTextColor,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor ?? themeProvider.primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
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