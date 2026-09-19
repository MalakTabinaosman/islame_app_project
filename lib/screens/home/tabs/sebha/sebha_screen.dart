import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int _counter = 0;
  double _turns = 0.0;
  int _tasbehIndex = 0;
  final List<String> tasbhe = [" سبحان الله ", " الحمد لله ", " الله اكبر "];

  void _onSebhaTap() {
    setState(() {
      _counter++;
      _turns += 1 / 33;

      if (_counter > 33) {
        _counter = 1;
        _tasbehIndex = (_tasbehIndex + 1) % tasbhe.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                " سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
                style: titleLarge(color: AppColors.white),
              ),
            ),

            const SizedBox(height: 30),
            GestureDetector(
              onTap: _onSebhaTap,
              child: Column(
                children: [
                  Image.asset("assets/images/Group37.png"),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedRotation(
                        turns: _turns,
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset("assets/images/SebhaBody.svg"),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tasbhe[_tasbehIndex],
                            style: titleLarge(color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "$_counter",
                            style: titleLarge(color: AppColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
