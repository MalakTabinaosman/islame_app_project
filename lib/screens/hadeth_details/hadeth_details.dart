import 'package:flutter/material.dart';
import 'package:islami_c20_dokki/models/hadeth.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';

class HadethDetails extends StatefulWidget {
  static const String routeName = "/hadeth-details";
  final Hadeth hadeth;

  HadethDetails({required this.hadeth, super.key});

  @override
  State<HadethDetails> createState() => _HadethDetailsState();
}

class _HadethDetailsState extends State<HadethDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(widget.hadeth.title),
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
                      child: Text(widget.hadeth.title, style: titleLarge() , textAlign: .center,),
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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.hadeth.content,
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
}
