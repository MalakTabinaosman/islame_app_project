import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/screens/home/tabs/hadeth/hadeth_tab.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/quran_tab.dart';
import 'package:islami_c20_dokki/screens/home/tabs/sebha/sebha_screen.dart';
import 'package:islami_c20_dokki/screens/home/widgets/base_tab.dart';

import 'package:islami_c20_dokki/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    BaseTab(image: "assets/images/quran_bg.png", child: QuranTab()),
    BaseTab(image: "assets/images/hadith_bg.png", child: HadethTab()),
    BaseTab(image: "assets/images/sebha_bg.png", child: SebhaScreen()),
    BaseTab(
      image: "assets/images/radio_bg.png",
      child: Container(color: Colors.purple),
    ),
    BaseTab(
      image: "assets/images/more_bg.png",
      child: Container(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      backgroundColor: AppColors.black,
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        backgroundColor: AppColors.gold,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          if (newIndex != selectedIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: buildItemIcon(
              selectedIndex == 0,
              "assets/images/ic_quran.png",
            ),
            label: "Quran",
          ),
          BottomNavigationBarItem(
            icon: buildItemIcon(
              selectedIndex == 1,
              "assets/images/ic_hadeth.png",
            ),
            label: "Hadeth",
          ),
          BottomNavigationBarItem(
            icon: buildItemIcon(
              selectedIndex == 2,
              "assets/images/ic_sebha.png",
            ),
            label: "Sebha",
          ),
          BottomNavigationBarItem(
            icon: buildItemIcon(
              selectedIndex == 3,
              "assets/images/ic_radio.png",
            ),
            label: "Radio",
          ),
          BottomNavigationBarItem(
            icon: buildItemIcon(
              selectedIndex == 4,
              "assets/images/ic_time.png",
            ),
            label: "Time",
          ),
        ],
      ),
    );
  }

  Widget buildItemIcon(bool isSelected, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.black.withAlpha(70) : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ImageIcon(AssetImage(iconPath)),
    );
  }
}
