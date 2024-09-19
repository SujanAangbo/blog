import 'package:blog/core/theme/app_pallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final isLoading;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            AppPallet.gradient1,
            AppPallet.gradient2,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: AppPallet.transparentColor,
          shadowColor: AppPallet.transparentColor,
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}
