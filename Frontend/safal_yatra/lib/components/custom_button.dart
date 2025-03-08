import 'package:flutter/material.dart';
import 'package:safal_yatra/components/appColors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String title;
  final double fontSize;
  final double width;
  final bool isLoading;

  final Function onTap;
  const CustomButton({
    super.key,
    //this.color = const Color(0xFF1a73e8),
    this.color = AppColors.buttonColor,
    required this.title,
    required this.onTap,
    this.fontSize = 22,
    this.width = 400,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () => onTap?.call(),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // color: const Color(0xFF1a73e8),
            color: const Color(0xFF57C00),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  final Color color;
  final String title;
  final double fontSize;
  final double width;
  final bool isLoading;

  final Function onTap;
  const CustomButtons({
    super.key,
    //this.color = const Color(0xFF1a73e8),
    this.color = AppColors.buttonColor,
    required this.title,
    required this.onTap,
    this.fontSize = 20,
    this.width = 400,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () => onTap?.call(),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // color: const Color(0xFF1a73e8),
            color: AppColors.buttonColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}