import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/username/username_cubit.dart';
import 'package:flowly/widgets/intro_background.dart';
import 'package:flowly/widgets/transaprent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const IntroBackground(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  right: 20,
                  left: 20,
                  bottom: 100,
                ),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,

                      'For better we need your name before continue.',
                      style: TextStyle(
                        height: 1,
                        fontSize: 35,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.buttonSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Felipe',
                            ),
                            onChanged: (value) =>
                                context.read<UserNameCubit>().saveName(value),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    TransaprentButton(
                      onPressed: () {
                        context.pushReplacement('/home');
                      },
                      child: Container(
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryDark,
                              AppColors.primaryLight,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Im ready',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
