import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_c20_dokki/models/sura.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

class SuraDetails extends StatefulWidget {
  static const String routeName = "/sura-details";
  final Sura sura;

  SuraDetails({required this.sura, super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  String content = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(widget.sura.nameEn),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/corner_decoration.png",
                    width: size.width * 0.2,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(widget.sura.nameAr, style: titleLarge()),
                    ),
                  ),
                  Transform.flip(
                    flipX: true,
                    child: Image.asset(
                      "assets/images/corner_decoration.png",
                      width: size.width * 0.2,
                    ),
                  ),
                ],
              ),
            ),
            content.isEmpty
                ? CircularProgressIndicator()
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        content,
                        style: bodyLarge(),
                        textAlign: .center,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    var response = await rootBundle.loadString(
      "assets/files/${widget.sura.id}.txt",
    );

    debugPrint(response);
    response = response.trim();
    var versesList = response.split("\n");
    for (int i = 0; i < versesList.length; i++) {
      content = "$content [${i + 1}] ${versesList[i]}";
    }
    content = content.trim();
    debugPrint(content);
    setState(() {});
  }
}
