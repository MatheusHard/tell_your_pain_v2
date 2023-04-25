
import 'package:flutter/material.dart';
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
      body: ListView(
        children: const [
          BarChart(),
          ColumnChart()
        ],
      ),
    );
  }
}
