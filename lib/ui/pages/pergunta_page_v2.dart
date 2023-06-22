
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/database/repositories/EscolaRepository.dart';
import 'package:tell_your_pain_v2/ui/models/escola.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../api/resposta_api.dart';
import '../database/db_helper.dart';
import '../database/repositories/RespostaRepository.dart';
import '../enums/dimensao.dart';
import '../enums/resposta_codigo.dart';
import '../enums/status_envio.dart';
import '../models/resposta.dart';
import '../models/usuario.dart';

class PerguntaPage2 extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;

  const PerguntaPage2(this.usuarioLogado, {Key? key}) : super(key: key);

  @override
  State<PerguntaPage2> createState() => _PerguntaPage2State();
}

class _PerguntaPage2State extends State<PerguntaPage2> {

  ScreenArgumentsUsuario? usuarioLogado;

  bool _pressedIconMuitoFeliz = true;
  bool _pressedIconFeliz = true;
  bool _pressedIconNormal = true;
  bool _pressedIconTriste = true;
  bool _pressedIconMuitoTriste = true;
  //
  bool _pressedFamilia = true;
  bool _pressedSaude = true;
  bool _pressedEscola = true;
  bool _pressedProfessores = true;
  bool _pressedEstudos = true;
  bool _pressedColegas = true;
  int _perguntaTipo = -1;

  var textos = [
    "Família",
    "Saúde",
    "Escola",
    "Professores",
    "Estudos",
    "Colegas"

  ];

  var images = [
    'assets/images/familia.png',
    'assets/images/saude.png',
    'assets/images/escola.png',
    'assets/images/professor.png',
    'assets/images/estudo.png',
    'assets/images/amigos.png',

  ];
  String muitoTriste =  'assets/images/Triste.png';

  final _textoEmogis = [
    'Muito triste',
    'Triste',
    'Normal',
    'Feliz',
    'Muito feliz',
  ];

  late Escola? escola;

  @override
  void initState() {
    usuarioLogado = widget.usuarioLogado;
    ///Get Escola do Aluno:
    //_getEscola(usuarioLogado?.data.escolaId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    //ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;
    //_getEscola(usuarioLogado?.data.escolaId);

    return WillPopScope(
        onWillPop: ()  async {
          print("Precionou voltar pra HomePage");
          _enviarRespostasApi();
          return true;
        },
        child: Scaffold(
        //appBar: AppBarUsuario(usuarioLogado,  ", como se sente?", context),
        appBar: _appBar(width, usuarioLogado, "como se sente?"),
        body:
          Container(
              color: Colors.grey.withOpacity(0.2),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

        ///Temas do Sentimento;
        Row(
        mainAxisAlignment: MainAxisAlignment.center,

          children: [
           ///Tema Familia
           Container(
                decoration: BoxDecoration(
                  color:   _pressedFamilia ? Colors.white : Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    )]
                ),
                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.width / 3.1,
               // color: _pressedFamilia ? Colors.transparent : Colors.grey.withOpacity(0.5),

                child:
                _inkWellTema(Dimensao.FAMILIA.index, 0, 0),

              ),

          const Padding(padding: EdgeInsets.all(4.0)),

            /**CARD SAÚDE*/
            Container(
              decoration: BoxDecoration(
                  color:   _pressedSaude ? Colors.white : Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    )]
              ),
                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.width / 3.1,


                child: _inkWellTema(Dimensao.SAUDE.index, 1, 1),

            ),

          ],
        ),
            const Padding(padding: EdgeInsets.only(top: 4.0)),

            ///2ª ROW
            ///Escola
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //childAspectRatio: MediaQuery.of(context).size.width /
              //  (MediaQuery.of(context).size.height / 2.6),
              //),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:   _pressedEscola ? Colors.white : Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        )]
                  ),
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: MediaQuery.of(context).size.width / 3.1,


                  child: _inkWellTema(Dimensao.ESCOLA.index, 2, 2),

                ),
                const Padding(padding: EdgeInsets.all(4.0)),

                ///CARD Professores
                Container(
                  decoration: BoxDecoration(
                      color:   _pressedProfessores ? Colors.white : Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        )]
                  ),
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: MediaQuery.of(context).size.width / 3.1,


                  child: _inkWellTema(Dimensao.PROFESSORES.index, 3, 3),

                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 4.0)),

            ///3ª ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //childAspectRatio: MediaQuery.of(context).size.width /
              //  (MediaQuery.of(context).size.height / 2.6),
              //),
              children: [
                ///CARD ESTUDOS
                Container(
                  decoration: BoxDecoration(
                      color:   _pressedEstudos ? Colors.white : Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        )]
                  ),
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: MediaQuery.of(context).size.width / 3.1,


                  child: _inkWellTema(Dimensao.ESTUDOS.index, 4, 4),

                ),
                const Padding(padding: EdgeInsets.all(4.0)),

                ///Card Colegas
                Container(
                  decoration: BoxDecoration(
                      color:   _pressedColegas ? Colors.white : Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        )]
                  ),
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: MediaQuery.of(context).size.width / 3.1,


                  child: _inkWellTema(Dimensao.COLEGAS.index, 5, 5),

                ),
              ],
            ),

            const SizedBox(
              height: 20,
              width: 20,
            ),

            ///INICIO EMOGIS
            ///Emogi Muito Triste
            Row(
                children: [
                  Column(
                    children: [
                      InkWell(

                        onTap: () {
                          setState(() {
                            _changeIcons(RespostaCodigo.MUITO_TRISTE.index);
                            _registrar(RespostaCodigo.MUITO_TRISTE.index, usuarioLogado);

                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10 ),
                          child:
                          Image.asset(
                            _pressedIconMuitoTriste ? muitoTriste : 'assets/images/TristeSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10 , top: 5),
                        child:
                        Text(_textoEmogis[0], style: _estiloEmogis(35),),
                      )

                    ],
                  ),
                  ///Emogi Triste
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _changeIcons(RespostaCodigo.TRISTE.index);
                            _registrar(RespostaCodigo.TRISTE.index, usuarioLogado);


                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 18),
                          child: Image.asset(
                            _pressedIconTriste ? 'assets/images/Chateado.png': 'assets/images/ChateadoSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 18 , top: 5),
                        child: Text(_textoEmogis[1], style: _estiloEmogis(35),),
                      )
                    ],
                  ),
                  ///Emogi Normal
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _changeIcons(RespostaCodigo.NORMAL.index);
                            _registrar(RespostaCodigo.NORMAL.index, usuarioLogado);

                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 18),
                          child: Image.asset(
                            _pressedIconNormal ? 'assets/images/Normal.png': 'assets/images/NormalSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 18 , top: 5),
                        child: Text(_textoEmogis[2], style: _estiloEmogis(35),),
                      )
                    ],
                  ),
                  ///Emogi Feliz
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _changeIcons(RespostaCodigo.FELIZ.index);
                            _registrar(RespostaCodigo.FELIZ.index, usuarioLogado);

                          });
                         // Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 18),
                          child: Image.asset(
                            _pressedIconFeliz == true ? 'assets/images/Feliz.png': 'assets/images/FelizSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 18 , top: 5),
                        child: Text(_textoEmogis[3], style: _estiloEmogis(35),),
                      )
                    ],
                  ),
                  ///Emogi Muito Feliz
                  Column(
                    children: [
                      InkWell(

                        onTap: () {
                          setState(() {
                            _changeIcons(RespostaCodigo.MUITO_FELIZ.index);
                            _registrar(RespostaCodigo.MUITO_FELIZ.index, usuarioLogado);

                          });

                          //Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20),
                          child: Image.asset(
                            _pressedIconMuitoFeliz == true ? 'assets/images/Muito_Feliz.png' : 'assets/images/MuitoFelizSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 20 , top: 5),
                        child: Text(_textoEmogis[4] , style: _estiloEmogis(35)),
                      )
                    ],
                  ),
                ],
              ),
          /*  ),*/
            ///FIM EMOGIS

          ]

        )

            )



     )
    );



  }

  _appBar(double width, ScreenArgumentsUsuario? usuarioLogado, String texto){

    var splitNome = usuarioLogado?.data.nome.split(' ');
    var nome =  splitNome[0] ?? '';

    return AppBar(
      toolbarHeight: 70,
      elevation: 0.0,
      flexibleSpace: Container(
        height: width / 3.5,
        decoration:  const BoxDecoration(
          gradient: AppGradients.petMacho,
          color: Colors.orange,
          boxShadow:  [
            BoxShadow(blurRadius: 50.0)
          ],

        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(width: width /10,),
            ///Foto:
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  Image.asset(
                ///TODO Imagem do usuario
                'assets/images/usuario.png',
                height: MediaQuery.of(context).size.width / 10,
                //   width: MediaQuery.of(context).size.width / 10,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            ///NOme
            SizedBox(
              height: (MediaQuery.of(context).size.width / 10) - 17,
              // width: MediaQuery.of(context).size.width / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text('''Olá $nome, $texto''' , style: AppTextStyles.titleAppBarUsuario(25, context),)),

                ],),
            )

          ],
        ),
        _sizedBox(10)
      ],
      //leadingWidth: 220,

    );
  }
  _sizedBox(double width){
    return SizedBox(
      width: width,
    );
  }
  InkWell _inkWellTema(int tipoSentimento, int imagemTema, int textoTema) {
    return InkWell(
      onTap: () async {
        setState(() {
          _changeTemaSentimento(tipoSentimento);

          //_showDialogBuilder(context);

        });
//                click(index, context, usuarioLogado?.data);

      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            images[imagemTema],
            width: 50,
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              textos[textoTema],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );

  }
  TextStyle _estiloEmogis(var numero){

    return TextStyle(fontSize: MediaQuery.of(context).size.width / numero);
  }

  _changeTemaSentimento(int numero){

    switch(numero){
      case 0:
          _perguntaTipo = 0;
         _pressedFamilia = !_pressedFamilia;
         _pressedSaude = true;
         _pressedEscola = true;
         _pressedProfessores = true;
         _pressedEstudos = true;
         _pressedColegas = true;
      break;
      case 1:
         _perguntaTipo = 1;
        _pressedFamilia = true;
        _pressedSaude = !_pressedSaude;
        _pressedEscola = true;
        _pressedProfessores = true;
        _pressedEstudos = true;
        _pressedColegas = true;break;
      case 2:
        _perguntaTipo = 2;
        _pressedFamilia = true;
        _pressedSaude = true;
        _pressedEscola = !_pressedEscola;
        _pressedProfessores = true;
        _pressedEstudos = true;
        _pressedColegas = true;
      break;
      case 3:
        _perguntaTipo = 3;
        _pressedFamilia = true;
        _pressedSaude = true;
        _pressedEscola = true;
        _pressedProfessores = !_pressedProfessores;
        _pressedEstudos = true;
        _pressedColegas = true;
        break;
      case 4:
        _perguntaTipo = 4;
        _pressedFamilia = true;
        _pressedSaude = true;
        _pressedEscola = true;
        _pressedProfessores = true;
        _pressedEstudos = !_pressedEstudos;
        _pressedColegas = true;
      break;
      case 5:
        _perguntaTipo = 5;
        _pressedFamilia = true;
        _pressedSaude = true;
        _pressedEscola = true;
        _pressedProfessores = true;
        _pressedEstudos = true;
        _pressedColegas = !_pressedColegas;
        break;
    }
    print("_perguntaTipo $_perguntaTipo");
  }
  _changeIcons(int numero){

    switch(numero){
      case 1:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = true;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = !_pressedIconMuitoTriste;
        break;
      case 2:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = true;
        _pressedIconTriste = !_pressedIconTriste;
        _pressedIconMuitoTriste = true;
        break;
      case 3:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = !_pressedIconNormal;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = true;
        break;
      case 4:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = !_pressedIconFeliz;
        _pressedIconNormal = true;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = true;
        break;
      case 5:
         _pressedIconMuitoFeliz = !_pressedIconMuitoFeliz;
         _pressedIconFeliz = true;
         _pressedIconNormal = true;
         _pressedIconTriste = true;
         _pressedIconMuitoTriste = true;
        break;
    }
  }
  void _registrar(int indexSentimento, var usuarioLogado) async {

    var geoLocalizacao = await Utils.getGeolocalizacao();

    var respostaRepository =  RespostaRepository(await DBHelper.instance.database);

    print("PerguntaTipo: $_perguntaTipo");
    print("Indice Sentimento: $indexSentimento");

    if(_perguntaTipo == -1) {
      if(!mounted) return;
      Utils.showDefaultSnackbar(context, "Selecione um Tema!!!");
      return;
    }
    var meuEnderecoIp = await Utils.getIpDevice();

    Resposta resposta = Resposta(id: Utils.generateGuide(),
                                alunoId: usuarioLogado.data.id, statusEnvio: StatusEnvio.A_ENVIAR.index,
                                erros: "", respostaCodigo: indexSentimento, dataResposta: Utils.getDataHoraDotNet(),
                                geoReferenciamento: '''${geoLocalizacao.latitude};${geoLocalizacao.longitude}''' ,
                                enderecoIp: meuEnderecoIp, dimensaoId: _perguntaTipo);

      int res = await respostaRepository.add(resposta).catchError((error){
        Utils.showDefaultSnackbar(context, '''Sentimento não salvo -> [ ${error.toString().substring(0,35)} ]...''');
      });
      setState(() {
         zerarBooleansSelected();
      });


    if(res > 0){
     if(!mounted) return;
     //Utils.showDefaultSnackbar(context, "Sentimento salvo");
   }


  }
  Future<int> zerarBooleansSelected() async {


    _perguntaTipo = -1;

    _pressedFamilia = true;
    _pressedSaude = true;
    _pressedEscola = true;
    _pressedProfessores = true;
    _pressedEstudos = true;
    _pressedColegas = true;

      _pressedIconMuitoFeliz = true;
      _pressedIconFeliz = true;
      _pressedIconNormal = true;
      _pressedIconTriste = true;
      _pressedIconMuitoTriste = true;

      return 1;
  }

  void _getEscola(escolaId) async {

    var escolaRepository =  EscolaRepository(await DBHelper.instance.database);
    escola = await escolaRepository.getById(escolaId);
    setState(() {
      escola;
      print(escola);

    });
  }
  ///Enviar respostas ao sair da Page:
  _enviarRespostasApi() async{

    var lista = [];
    if(await Utils.isConnected()) RespostaApi(context).enviarRespostas(lista);

  }


}
