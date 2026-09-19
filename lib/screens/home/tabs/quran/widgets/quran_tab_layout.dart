import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/quran_tab.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/widgets/most_recent_sura_widget.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/widgets/sura_widget.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

import '../../../../../models/sura.dart';

class QuranTabLayout extends StatelessWidget {
  final List<Sura> mostRecent;
  final SuraWidgetOnClickCallBack callBack;

  const QuranTabLayout({
    required this.mostRecent,
    required this.callBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          if (mostRecent.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Most Recent",
                  style: titleMedium(color: AppColors.white),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => MostRecentSuraWidget(
                    sura: mostRecent[index],
                    callBack: callBack,
                  ),
                  separatorBuilder: (_, _) => SizedBox(width: 16),
                  itemCount: mostRecent.length,
                ),
              ),
            ),
          ],
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Suras List",
                style: titleMedium(color: AppColors.white),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverList.separated(
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SuraWidget(sura: surasList[index], callBack: callBack),
            ),
            separatorBuilder: (_, _) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: AppColors.white, indent: 40, endIndent: 40),
            ),
            itemCount: 114,
          ),
        ],
      ),
    );
  }
}
