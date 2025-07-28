import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
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
