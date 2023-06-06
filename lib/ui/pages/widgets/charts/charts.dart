
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/bar_chart.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/column_chart.dart';

import '../../screen_arguments/screen_arguments_usuario.dart';
import '../../utils/core/app_colors.dart';



class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {


  @override
  Widget build(BuildContext context) {
    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return Scaffold(
      backgroundColor: AppColors.red,
      body: Padding(
        padding: const EdgeInsets.only( left:8.0, right: 8.0),
        child: Container(
          color: AppColors.levelButtonTextFacil,
          child: ListView(
            children:  [
              BarChart(usuarioLogado),
              ColumnChart(usuarioLogado)
            ],
          ),
        ),
      ),
    );
  }
}
