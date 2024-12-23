import 'package:commune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.login),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 48),
              _buildLoginButton(
                context: context,
                ref: ref,
                title: AppStrings.loginWithGoogle,
                icon: 'assets/icons/google.svg',
                backgroundColor: AppColors.googleButton,
                onPressed: () => _handleGoogleLogin(context, ref),
              ),
              const SizedBox(height: 16),
              _buildLoginButton(
                context: context,
                ref: ref,
                title: AppStrings.loginWithNaver,
                icon: 'assets/icons/naver.svg',
                backgroundColor: AppColors.naverButton,
                onPressed: () => _handleNaverLogin(context, ref),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }

  Future<void> _handleGoogleLogin(BuildContext context, WidgetRef ref) async {
    try {
      final result = await ref.read(authProvider).signInWithGoogle();
      
      if (context.mounted) {
        if (result.isNewUser) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('환영해요!'),
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true,
            ),
          );
        }
        Navigator.of(context).pushReplacementNamed('/');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
          ),
        );
      }
    }
  }

  Future<void> _handleNaverLogin(BuildContext context, WidgetRef ref) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.servicePreparation),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }
}
