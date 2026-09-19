import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/models/sura.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/widgets/quran_search_layout.dart';
import 'package:islami_c20_dokki/screens/home/tabs/quran/widgets/quran_tab_layout.dart';
import 'package:islami_c20_dokki/screens/sura_details/sura_details.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SuraWidgetOnClickCallBack = Future<void> Function(Sura);

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  TextEditingController controller = TextEditingController(text: "");
  List<Sura> searchResults = [];
  List<Sura> mostRecent = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _fetchMostRecent();
    controller.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

      // 2. Start a new timer with your preferred debounce delay (e.g., 500ms)
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        searchSurasList(controller.text);
      });
    });
  }

  void searchSurasList(String input) {
    if (input.isEmpty) {
      searchResults = [];
      setState(() {});
      return;
    }
    if (int.tryParse(input) != null) {
      searchResults = surasList
          .where((sura) => sura.id == int.parse(input))
          .toList();
      setState(() {});
      return;
    }
    if (RegExp("^[A-Za-z ]+").hasMatch(input)) {
      searchResults = surasList
          .where(
            (sura) => sura.nameEn.toLowerCase().contains(input.toLowerCase()),
          )
          .toList();
    } else {
      searchResults = surasList
          .where((sura) => sura.nameAr.contains(input))
          .toList();
    }
    setState(() {});
  }

  Future<void> _fetchMostRecent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> mostRecentSuraList =
        sharedPreferences.getStringList("mostRecent") ?? [];
    mostRecent = [];
    for (String id in mostRecentSuraList) {
      mostRecent.add(surasList[(int.parse(id) - 1)]);
    }
    setState(() {});
  }

  Future<void> _updateMostRecentList(Sura sura) async {
    String id = sura.id.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> mostRecentSuraList =
        sharedPreferences.getStringList("mostRecent") ?? [];
    if (mostRecentSuraList.contains(id)) {
      mostRecentSuraList.remove(id);
    }
    mostRecentSuraList = [id, ...mostRecentSuraList];
    await sharedPreferences.setStringList("mostRecent", mostRecentSuraList);
    _fetchMostRecent();
    Navigator.pushNamed(context, SuraDetails.routeName, arguments: sura);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            style: titleMedium(color: AppColors.white),
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              hintText: "Search for Sura",
              hintStyle: titleMedium(color: AppColors.white),
              fillColor: AppColors.black.withAlpha(90),
              prefixIcon: ImageIcon(AssetImage("assets/images/ic_quran.png")),
              prefixIconColor: AppColors.gold,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.gold, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.gold, width: 2),
              ),
            ),
          ),
        ),
        if (searchResults.isEmpty && controller.text.isEmpty)
          QuranTabLayout(
            mostRecent: mostRecent,
            callBack: _updateMostRecentList,
          )
        else
          QuranSearchLayout(
            surasList: searchResults,
            callBack: _updateMostRecentList,
          ),
      ],
    );
  }
}
