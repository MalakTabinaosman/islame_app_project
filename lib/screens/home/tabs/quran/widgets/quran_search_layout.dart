import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/models/sura.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/quran_tab.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/widgets/sura_widget.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';
import 'package:lottie/lottie.dart';

class QuranSearchLayout extends StatelessWidget {
  final List<Sura> surasList;
  final SuraWidgetOnClickCallBack callBack;

  const QuranSearchLayout({required this.surasList , required this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    if (surasList.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Lottie.asset(
                "assets/animations/Man reads Quran on Ramadan.json",
                height: MediaQuery.sizeOf(context).height * 0.4,
              ),
              Text("No Results Found", style: titleSmall()),
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemBuilder: (_, index) => SuraWidget(sura: surasList[index] , callBack: callBack,),
        separatorBuilder: (_, _) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(color: AppColors.white, indent: 40, endIndent: 40),
        ),
        itemCount: surasList.length,
      ),
    );
  }
}
