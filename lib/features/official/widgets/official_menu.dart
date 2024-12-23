// #File: lib/features/official/widgets/official_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';

class OfficialMenu extends ConsumerStatefulWidget {
  const OfficialMenu({super.key});

  @override
  ConsumerState<OfficialMenu> createState() => _OfficialMenuState();
}

class _OfficialMenuState extends ConsumerState<OfficialMenu> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.verified),
          title: Text(AppStrings.registerOfficial),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded) ...[
          _buildOfficialOption(
            icon: Icons.person,
            title: AppStrings.politician,
            onTap: () => _navigateToRegistration('politician'),
          ),
          _buildOfficialOption(
            icon: Icons.groups,
            title: AppStrings.party,
            onTap: () => _navigateToRegistration('party'),
          ),
          _buildOfficialOption(
            icon: Icons.newspaper,
            title: AppStrings.media,
            onTap: () => _navigateToRegistration('media'),
          ),
          _buildOfficialOption(
            icon: Icons.poll,
            title: AppStrings.pollster,
            onTap: () => _navigateToRegistration('pollster'),
          ),
          _buildOfficialOption(
            icon: Icons.how_to_vote,
            title: AppStrings.candidate,
            subtitle: AppStrings.servicePreparation,
            onTap: () => _showPreparationMessage(),
          ),
        ],
      ],
    );
  }

  Widget _buildOfficialOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      contentPadding: const EdgeInsets.only(left: 32),
      dense: true,
      onTap: onTap,
    );
  }

  void _navigateToRegistration(String type) {
    Navigator.of(context).pushNamed(
      '/official-registration',
      arguments: {'type': type},
    );
  }

  void _showPreparationMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.servicePreparation),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }
}