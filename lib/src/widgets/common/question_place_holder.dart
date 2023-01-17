import 'package:easy_separator/easy_separator.dart';
import 'package:educational_app/src/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class QuestionPlaceHolder extends StatelessWidget {
  const QuestionPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: AppLayout.getHeight(12),
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    var answer = Container(
      width: double.infinity,
      height: AppLayout.getHeight(50),
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.blueGrey.withOpacity(0.5),
      child: EasySeparatedColumn(
        separatorBuilder: (BuildContext context, int index) {
          return Gap(
            AppLayout.getHeight(20),
          );
        },
        children: [
          EasySeparatedColumn(
            children: [
              line,
              line,
              line,
              line,
            ],
            separatorBuilder: (BuildContext context, int index) {
              return Gap(
                AppLayout.getHeight(10),
              );
            },
          ),
          answer,
          answer,
          answer,
        ],
      ),
    );
  }
}
