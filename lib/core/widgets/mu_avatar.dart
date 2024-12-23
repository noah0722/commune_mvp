// #File: lib/core/widgets/mu_avatar.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/core/constants/app_colors.dart';

class MuAvatar extends StatelessWidget {
  final Mu mu;
  final double radius;
  final bool showBadge;
  final bool showBorder;
  final VoidCallback? onTap;

  const MuAvatar({
    super.key,
    required this.mu,
    this.radius = 20,
    this.showBadge = false,
    this.showBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: showBorder ? Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ) : null,
            ),
            child: ClipOval(
              child: mu.profileImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: mu.profileImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          if (showBadge && (mu.isOfficial || mu.isVerified || _hasSpecialBadge())) ...[
            Positioned(
              right: -radius * 0.3,
              bottom: -radius * 0.1,
              child: _buildBadge(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.backgroundSecondary,
      child: Icon(
        Icons.people,
        size: radius,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    Color badgeColor;
    IconData badgeIcon;
    double badgeSize = radius * 0.8;

    if (mu.isOfficial) {
      badgeColor = AppColors.officialBadge;
      badgeIcon = Icons.verified;
    } else if (mu.isVerified) {
      badgeColor = AppColors.verifiedBadge;
      badgeIcon = Icons.verified_user;
    } else if (mu.topicLevel2 == '국회의원') {
      badgeColor = AppColors.rankGold;
      badgeIcon = Icons.workspace_premium;
    } else if (mu.topicLevel2 == '시도지사') {
      badgeColor = AppColors.rankSilver;
      badgeIcon = Icons.location_city;
    } else {
      // Default badge
      badgeColor = AppColors.primaryColor;
      badgeIcon = Icons.check_circle;
    }

    return Container(
      padding: EdgeInsets.all(radius * 0.1),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: badgeSize,
        height: badgeSize,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          badgeIcon,
          color: Colors.white,
          size: badgeSize * 0.7,
        ),
      ),
    );
  }

  bool _hasSpecialBadge() {
    return mu.topicLevel2 == '국회의원' || 
           mu.topicLevel2 == '시도지사' || 
           mu.topicLevel2 == '대통령';
  }
}

class MuAvatarGroup extends StatelessWidget {
  final List<Mu> mus;
  final double avatarRadius;
  final int maxDisplayed;
  final VoidCallback? onOverflowTap;

  const MuAvatarGroup({
    super.key,
    required this.mus,
    this.avatarRadius = 16,
    this.maxDisplayed = 3,
    this.onOverflowTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayedMus = mus.take(maxDisplayed).toList();
    final remainingCount = mus.length - maxDisplayed;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...displayedMus.map((mu) => Padding(
          padding: EdgeInsets.only(
            right: avatarRadius * 0.5,
          ),
          child: MuAvatar(
            mu: mu,
            radius: avatarRadius,
          ),
        )),
        if (remainingCount > 0)
          GestureDetector(
            onTap: onOverflowTap,
            child: Container(
              width: avatarRadius * 2,
              height: avatarRadius * 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    fontSize: avatarRadius * 0.8,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}