import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/username/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 30,
            bottom: 130,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Kanit',
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Manage your account and preferences.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontFamily: 'Kanit',
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.border),
                ),
                child: BlocBuilder<UserNameCubit, UserNameState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state.userName.isNotEmpty)
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.25),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                state.userName[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.25),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                'A',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(height: 18),
                        if (state.userName.isNotEmpty)
                          Text(
                            state.userName,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Kanit',
                            ),
                          )
                        else
                          Text(
                            'Your Name',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Kanit',
                            ),
                          ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Kanit',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Settings',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Kanit',
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primaryLight,
                        ),
                      ),
                      title: const Text(
                        'Account',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'Personal information',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.warning,
                        ),
                      ),
                      title: const Text(
                        'Notifications',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'Reminders and alerts',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.info.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.palette_outlined,
                          color: AppColors.info,
                        ),
                      ),
                      title: const Text(
                        'Appearance',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'Theme and colors',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.labelPurple.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.language_rounded,
                          color: AppColors.labelPurple,
                        ),
                      ),
                      title: const Text(
                        'Language',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'App language',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.success,
                        ),
                      ),
                      title: const Text(
                        'Privacy',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'Privacy and security',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.labelOrange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.help_outline_rounded,
                          color: AppColors.labelOrange,
                        ),
                      ),
                      title: const Text(
                        'Help & Support',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'Get help with Flowly',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const Divider(height: 1, color: AppColors.divider),

                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.textTertiary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      title: const Text(
                        'About',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      subtitle: const Text(
                        'App information',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.danger.withOpacity(0.35),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, color: AppColors.danger),
                      SizedBox(width: 10),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: AppColors.danger,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Flowly',
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 13,
                    fontFamily: 'Kanit',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
