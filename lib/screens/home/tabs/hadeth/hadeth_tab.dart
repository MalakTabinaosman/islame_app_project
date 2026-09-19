import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_c20_dokki/models/hadeth.dart';
import 'package:islami_c20_dokki/screens/hadeth_details/hadeth_details.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<StatefulWidget> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<Hadeth> ahadeth = [];

  @override
  void initState() {
    super.initState();
    loadAhadeth();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CarouselSlider.builder(
              itemCount: ahadeth.length,
              itemBuilder: (context, index, _) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    HadethDetails.routeName,
                    arguments: ahadeth[index],
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/HadithCardBackGround.png",
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 16,
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/images/corner_decoration.png"),
                            size: 80,
                          ),
                          Expanded(
                            child: Text(
                              ahadeth[index].title,
                              style: titleMedium(color: AppColors.black),
                              textAlign: .center,
                            ),
                          ),
                          Transform.flip(
                            flipX: true,
                            child: ImageIcon(
                              AssetImage("assets/images/corner_decoration.png"),
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          ahadeth[index].content,
                          style: bodyLarge(color: AppColors.black),
                          textAlign: .center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              options: CarouselOptions(
                height: double.infinity,
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> loadAhadeth() async {
    for (int i = 1; i <= 50; i++) {
      var hadeth = await rootBundle.loadString("assets/files/h$i.txt");
      var hadethContent = hadeth.trim().split("\n").map((content) {
        return content.trim();
      }).toList();
      var hadethTitle = hadethContent.first;
      var hadethBody = hadethContent.sublist(1).join(" " ?? "");
      ahadeth.add(Hadeth(i, hadethTitle, hadethBody));
    }
    print(ahadeth.length);
  }
}
