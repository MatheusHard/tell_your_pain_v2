import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';

import '../../../database/db_helper.dart';
import '../../../database/repositories/RespostaRepository.dart';
import '../../screen_arguments/screen_arguments_usuario.dart';
import '../../utils/metods/utils.dart';

class BarChart extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;

  const BarChart(this.usuarioLogado, {Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late List _listaRepostasByUsuarioId = [];
  double media = 0;
  double mediaGeral = 0;
  late List<ChartSampleData> chartData = [ ];
  final listaDimencoes = Utils.listaDimensoes();
  String urlEmoji = "";

  @override
  void initState() {
    ///Get Respostas:
   _getAllByUsuarioId(widget.usuarioLogado?.data.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return _columnWidget();
  }
  _columnWidget(){
    var width = MediaQuery.of(context).size.width;

    return  Container(

    height: 400,
      padding: const EdgeInsets.all(20),
      child:
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 3,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text('''Média Geral: ${ mediaGeral.isNaN ? 0.0 : mediaGeral}''',
                              style: AppTextStyles.titleAppBarUsuario(35, context),),
                            const SizedBox( width: 10),
                            //urlEmoji == "" ? Image.asset(urlEmoji, height: width / 20, width: width / 20,): Container()
                            mediaGeral > 0 && !mediaGeral.isNaN ?
                            Image.asset(Utils.respostaEmoji(mediaGeral), height: width / 20, width: width / 20,):
                            Container()
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              SfCartesianChart(
                title: ChartTitle(text: 'Temas dos Sentimentos'),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}M',
                    //title: AxisTitle(text: 'Shipments in million'),
                    majorGridLines: const MajorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(size: 0)),
                series: <ChartSeries<ChartSampleData, String>>[
                  BarSeries<ChartSampleData, String>(
                    onCreateRenderer: (ChartSeries<ChartSampleData, String> series) =>
                        _CustomColumnSeriesRenderer(),
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true, labelAlignment: ChartDataLabelAlignment.middle),
                    dataSource: chartData,
                    width: 0.8,
                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                  )
                ],
              ),
            ],
          ),
        ),
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
        ///Popular Columns:
        chartData.add(ChartSampleData(x: _getDimensao(item['dimensaoId']), y: double.parse(item['media'].toStringAsFixed(1))));
        var total = item['media'];
        media += total;
        cont ++;
      }
      var mediaFomatada = (media / cont).toStringAsFixed(1);
      mediaGeral  = double.parse(mediaFomatada);
      urlEmoji =  Utils.respostaEmoji(mediaGeral);

    });
  }
  _getDimensao(int id){

    String dimensao = "";

    switch(id){
      case 0:
        dimensao =  listaDimencoes[0]['dimensao'];
        break;
      case 1:
        dimensao =  listaDimencoes[1]['dimensao'];
        break;
      case 2:
        dimensao =  listaDimencoes[2]['dimensao'];
        break;
      case 3:
        dimensao =  listaDimencoes[3]['dimensao'];
        break;
      case 4:
        dimensao =  listaDimencoes[4]['dimensao'];
        break;
      case 5:
        dimensao =  listaDimencoes[5]['dimensao'];
        break;
    }
    return dimensao;
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