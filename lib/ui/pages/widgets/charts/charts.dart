
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_colors.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/column_chart.dart';

import 'bar_chart.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: Padding(
        padding: const EdgeInsets.only( left:8.0, right: 8.0),
        child: Container(
          color: AppColors.levelButtonTextFacil,
          child: ListView(
            children: const [
              BarChart(),
              ColumnChart()
            ],
          ),
        ),
      ),
    );
  }
}
