import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';

// ignore: must_be_immutable
class ButtonEnter extends StatelessWidget {
  ButtonEnter({
    Key? key,
    required this.onTap,
    required this.isLoading,
    this.titleButton = 'Entrar',
  }) : super(key: key);

  final Function()? onTap;
  final bool isLoading;
  String? titleButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, //   controller.animatedContainer,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: isLoading ? Colors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 50,
        width: isLoading ? 50 : Get.width,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                ),
              )
            : Center(
                child: Text(
                  titleButton!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
