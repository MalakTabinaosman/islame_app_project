import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/models/sura.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/quran_tab.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

class MostRecentSuraWidget extends StatelessWidget {
  final Sura sura;
  final SuraWidgetOnClickCallBack callBack;

  const MostRecentSuraWidget({
    required this.sura,
    required this.callBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        callBack(sura);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceEvenly,
              children: [
                Text(sura.nameEn, style: titleMedium(color: AppColors.black)),
                Text(sura.nameAr, style: titleMedium(color: AppColors.black)),
                Text(
                  sura.versesNumber,
                  style: titleMedium(color: AppColors.black),
                ),
              ],
            ),
            Image.asset("assets/images/img_most_recent.png")
          ],
        ),
      ),
    );
  }
}
