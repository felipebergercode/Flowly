import 'package:flowly/core/app_colors.dart';
import 'package:flowly/widgets/intro_animation.dart';
import 'package:flowly/widgets/intro_background.dart';
import 'package:flowly/widgets/transaprent_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IntroBackground(),
          Positioned(
            top: 130,
            right: 40,
            left: 40,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 170,
              child: Image.asset('assets/icon.png'),
            ),
          ),
          IntroAnimation(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 350,
                  right: 40,
                  left: 40,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    Text(
                      'Flowly',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Organize work beautifully.',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textSecondary,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),

                    TransaprentButton(
                      onPressed: () {
                        context.pushReplacement('/welcome');
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Start and organize',
                            style: TextStyle(
                              fontSize: 20,
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
