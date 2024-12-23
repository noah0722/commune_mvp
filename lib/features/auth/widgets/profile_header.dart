// #File: lib/features/auth/widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commune/core/models/user.dart';
import 'package:commune/core/constants/app_colors.dart';

class ProfileHeader extends ConsumerWidget {
  final User user;

  const ProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildProfileImage(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUsername(context),
                      const SizedBox(height: 4),
                      _buildEmail(context),
                    ],
                  ),
                ),
                if (user.isVerified)
                  Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCommorePoints(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: user.profileImage != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: user.profileImage!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  size: 32,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          : const Icon(
              Icons.person,
              size: 32,
              color: AppColors.primaryColor,
            ),
    );
  }

  Widget _buildUsername(BuildContext context) {
    return Text(
      user.username,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Text(
      user.email,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCommorePoints(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.currency_exchange,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            '${user.commorePoints} 코몰',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}