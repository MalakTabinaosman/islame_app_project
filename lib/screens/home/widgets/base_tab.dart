import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';

class BaseTab extends StatelessWidget {
  final String image;
  final Widget child;

  const BaseTab({ required this.image, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black.withAlpha(100), AppColors.black],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Center(
                child: Image.asset(
                  "assets/images/img_header.png",
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
