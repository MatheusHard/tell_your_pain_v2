import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

import '../../../database/db_helper.dart';
import '../../../database/repositories/RespostaRepository.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({Key? key}) : super(key: key);

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  late List _listaRepostasByUsuarioId = [];
  double media = 0;
  double mediaGeral = 0;


  @override
  void initState() {
   _getAllByUsuarioId("fce27baa-53d8-49d2-9cbb-745e1d0b1e71");

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return _columnWidget();
  }
  _columnWidget(){

    return  Container(

      height: 400,
      padding: const EdgeInsets.all(20),
      child:
      Column(
          children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCartesianChart(
            title: ChartTitle(text: 'Temas dos Sentimentos'),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                labelFormat: '{value}M',
                title: AxisTitle(text: 'Shipments in million'),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <ChartSeries<ChartSampleData, String>>[
              BarSeries<ChartSampleData, String>(
                onCreateRenderer: (ChartSeries<ChartSampleData, String> series) =>
                    _CustomColumnSeriesRenderer(),
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true, labelAlignment: ChartDataLabelAlignment.middle),
                dataSource: <ChartSampleData>[
                  ChartSampleData(x: 'HP Inc', y: 12.54),
                  ChartSampleData(x: 'Lenovo', y: 13.46),
                  ChartSampleData(x: 'Dell', y: 9.18),
                  ChartSampleData(x: 'Apple', y: 4.56),
                  ChartSampleData(x: 'Asus', y: 5.29),
                  ChartSampleData(x: 'Samsumg', y: 20.29),

                ],
                width: 0.8,
                xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                yValueMapper: (ChartSampleData sales, _) => sales.y,
              )
            ],
          ),
        ),
      ),
      ]
    ));
  }
  void _getAllByUsuarioId(var id) async {

    _listaRepostasByUsuarioId = [];
    var respostaRepository =  RespostaRepository(await DBHelper.instance.database);
    List lista = await respostaRepository.getCountDistinctByUsuarioId(id);

    _listaRepostasByUsuarioId = lista;
    setState(() {
      _listaRepostasByUsuarioId;
      print(_listaRepostasByUsuarioId);
      double cont = 0;
      mediaGeral = 0;
      media = 0;


      for(var item in _listaRepostasByUsuarioId){

       var total  =  item['media'];
       media += total;

        cont ++;
      }
      var mediaFomatada = (media / cont).toStringAsFixed(1);
      mediaGeral  = double.parse(mediaFomatada);
      //urlEmoji =  _respostaEmoji(mediaTotal);
      print("media"+media.toString());
      print("count"+cont.toString());
      print("mediaGeral"+mediaGeral.toString());

    });
  }
}

class _CustomColumnSeriesRenderer extends BarSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  BarSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends BarSegment {
  final colorList = [
    const Color.fromRGBO(53, 92, 125, 1),
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1),
    const Color.fromRGBO(80, 50, 50, 1)

  ];

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex!];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.y});

  final dynamic x;
  final num? y;
}