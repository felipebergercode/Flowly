import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onSignUpPressed,
  });

  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onSignUpPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _OrDivider(),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: _SocialButton(
                onPressed: onGooglePressed,
                child: Image.asset('assets/google.png', width: 33, height: 33),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _SocialButton(
                onPressed: onApplePressed,
                child: const Icon(Icons.apple, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),

        const SizedBox(height: 36),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Color(0xFFA8ADBA),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: onSignUpPressed,
              child: const Text(
                'Sign up',
                style: TextStyle(
                  color: Color(0xFF8B7CFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(color: Color(0xFF252A35), thickness: 1, endIndent: 14),
        ),
        Text(
          'or continue with',
          style: TextStyle(
            color: Color(0xFF7D8492),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(color: Color(0xFF252A35), thickness: 1, indent: 14),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFF11151D),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF292F3A), width: 1),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
