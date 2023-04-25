
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tell_your_pain_v2/ui/database/db_helper.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/RespostaRepository.dart';
import 'package:tell_your_pain_v2/ui/enums/perguntaTipo.dart';
import 'package:tell_your_pain_v2/ui/enums/respostraCodigo.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';


class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {

  var selectedDimensao =  {"id": 0, "dimensao":"Família"};
  late List _listaRepostasColunas = [];
  late List _listaRepostasByDimensao = [];

  late List<ChartData> chartData = [ ];
  double media = 0;
  double mediaTotal = 0;

  final _respostas = [
    'Out',
    'Muito triste',
    'Triste',
    'Normal',
    'Feliz',
    'Muito feliz',
  ];
  final colorsColumn = [
    Colors.transparent,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.greenAccent

  ];

final listaDimencoes = Utils.listaDimensoes();
 late charts.TooltipBehavior _tooltip;

String urlEmoji = "";

  @override
  void initState() {
    _getByDimensao(selectedDimensao);
    _getRespostas(selectedDimensao);
    _tooltip = charts.TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _cardTitulo(chartData);

  }


   _cardTitulo(List<ChartData> chartData){
     var width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: [
            Row(
              children:[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 30,
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
                              Text('''Media: ${ mediaTotal ?? 0}''',
                                    style: AppTextStyles.titleAppBarUsuario(35, context),),
                              const SizedBox( width: 10),
                              //urlEmoji == "" ? Image.asset(urlEmoji, height: width / 20, width: width / 20,): Container()
                              mediaTotal > 0 && !mediaTotal.isNaN ?
                              Image.asset(_respostaEmoji(mediaTotal), height: width / 20, width: width / 20,):
                              Container()
                            ]
                      ),
                    ),
                  )

                ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: DropdownSearch<dynamic>(
                      mode: Mode.MENU,
                      items: listaDimencoes.map((rc) => rc).toList(),
                      itemAsString: (dynamic rc) => rc['dimensao'].toString(),
                      showSearchBox: true,
                      dropdownSearchDecoration: const InputDecoration(
                          labelText: 'Tema',
                          hintText: 'escolha o tipo'
                      ),
                      onChanged: (newDimensao) {
                        _getRespostas(newDimensao);
                        _getByDimensao(newDimensao);
                        _selectedItemDimensao(newDimensao);
                      },
                      selectedItem: _selectedItemDimensao(selectedDimensao),
                    ),
                  ),]
            ),

            Expanded(
              child: charts.SfCartesianChart(
                 // primaryXAxis: charts.CategoryAxis(),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}',
                    title: AxisTitle(text: 'Respostas'),
                    majorGridLines: const MajorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(size: 0)),
                palette: const <Color>[
                  Colors.teal,
                  Colors.orange,
                  Colors.brown
                ],
                  tooltipBehavior: _tooltip,

                  series: <charts.ChartSeries>[
                    charts.StackedColumnSeries<ChartData, String>(
                        dataLabelSettings: DataLabelSettings(
                            textStyle: AppTextStyles.titleAppBarUsuario(35, context),
                            isVisible: true, labelAlignment: ChartDataLabelAlignment.middle
                        ),
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        // Map color for each data points from the data source
                        pointColorMapper: (ChartData data, _) => data.color

              ),
          ],
        ),
            ),
      ]
      )
      ),
    );
  }

  void _getRespostas(var dimensao) async {

    _listaRepostasColunas = [];
    chartData = [];
    var respostaRepository =  RespostaRepository(await DBHelper.instance.database);
    List lista = await respostaRepository.getCountSentimentoByDimensao(dimensao['id']);
    _listaRepostasColunas = lista;
    setState(() {
      _listaRepostasColunas;
      int cont = 0;

      for(var item in _listaRepostasColunas){
        var total  =  item['total'];
        var respCodigo = _respostaCodigo(item['respostaCodigo']);

        chartData.add(ChartData(_respostas[respCodigo], total, colorsColumn[respCodigo]));

        cont ++;
      }


    });
  }

  int _respostaCodigo(int value){
    int retorno = 0;
    switch(value){
      case 1:
        retorno = RespostaCodigo.MUITO_TRISTE.index;
        break;
      case 2:
        retorno = RespostaCodigo.TRISTE.index;
        break;
      case 3:
        retorno = RespostaCodigo.NORMAL.index;
        break;
      case 4:
        retorno = RespostaCodigo.FELIZ.index;
        break;
      case 5:
        retorno = RespostaCodigo.MUITO_FELIZ.index;
        break;
    }
    return retorno;
  }

  String _respostaEmoji(double value){
    String url = "";
    var lista = Utils.listaUrlEmojis();

        if(value >= 0 && value < 1) url = lista[0];
        if(value >= 1 && value < 2) url = lista[1];
        if(value >= 2 && value < 3) url = lista[2];
        if(value >= 3 && value < 4) url = lista[3];
        if(value >= 4) url = lista[4];

    return url;
  }
  void _getByDimensao(var dimensao) async {

   _listaRepostasByDimensao = [];
  var respostaRepository =  RespostaRepository(await DBHelper.instance.database);
  List lista = await respostaRepository.getRespostaByDimensao(dimensao['id']);
   _listaRepostasByDimensao = lista;
  setState(() {
    _listaRepostasByDimensao;
    double cont = 0;
    mediaTotal = 0;
    media = 0;
    for(var item in _listaRepostasByDimensao){
      var total  =  item['respostaCodigo'];
      media += total;

      cont ++;
    }
    var mediaFomatada = (media / cont).toStringAsFixed(1);
    mediaTotal = double.parse(mediaFomatada);
    urlEmoji =  _respostaEmoji(mediaTotal);
    print("media"+media.toString());
    print("conunt"+cont.toString());
    print("meditotal"+mediaTotal.toString());

  });
  }
}
_selectedItemDimensao(var data) {
  return data;
}
  class ChartData {
    final String x;
    final int y;
    final Color? color;

    ChartData(this.x, this.y, this.color);

  }
