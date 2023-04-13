
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../database/db_helper.dart';
import '../database/repositories/RespostaRepository.dart';
import '../enums/perguntaTipo.dart';
import '../enums/statusEnvio.dart';
import '../models/resposta.dart';
import '../models/usuario.dart';

class PerguntaPage2 extends StatefulWidget {
  const PerguntaPage2({Key? key}) : super(key: key);

  @override
  State<PerguntaPage2> createState() => _PerguntaPage2State();
}

class _PerguntaPage2State extends State<PerguntaPage2> {

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
  final _textoEmogis = [
    'Muito triste',
    'Triste',
    'Normal',
    'Feliz',
    'Muito feliz',
  ];


  @override
  Widget build(BuildContext context) {

    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return Scaffold(
        appBar: AppBar(
          title:  Text('''Olá ${usuarioLogado != null ? usuarioLogado?.data.nome: ""}, como se sente?'''),
        ),


        body:

            Container(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /* GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: textos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2.6),
            ),
            itemBuilder: (BuildContext context, int index) {
              return     Card(
                  child: Container(

                    color: _pressed ? Colors.orange : Colors.transparent,

                    child: InkWell(
                      onTap: () async {
                          setState(() {
                            _pressed = !_pressed;

                            int? indice = index;
                            print("INDICE $indice");
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
                            images[index],
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              textos[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

            },
      ),*/
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //childAspectRatio: MediaQuery.of(context).size.width /
          //  (MediaQuery.of(context).size.height / 2.6),
            //),
          children: [
            Card(
            child: Container(
              width: MediaQuery.of(context).size.width / 2.6,
              height: MediaQuery.of(context).size.width / 3.1,
              color: _pressedFamilia ? Colors.transparent : Colors.grey.withOpacity(0.5),

              child: InkWell(
                onTap: () async {
                  setState(() {
                    _changeTemaSentimento(0);

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
                      images[0],
                      width: 50,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        textos[0],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
                ),
            /**CARD SAÚDE*/
            Card(
              child: Container(

                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.width / 3.1,
                color: _pressedSaude ? Colors.transparent : Colors.grey.withOpacity(0.5),

                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _changeTemaSentimento(1);

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
                        images[1],
                        width: 50,
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          textos[1],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
            /**2ª ROW*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //childAspectRatio: MediaQuery.of(context).size.width /
              //  (MediaQuery.of(context).size.height / 2.6),
              //),
              children: [
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.width / 3.1,
                    color: _pressedEscola ? Colors.transparent : Colors.grey.withOpacity(0.5),

                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _changeTemaSentimento(2);

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
                            images[2],
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              textos[2],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /**CARD Professores**/
                Card(
                  child: Container(

                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.width / 3.1,
                    color: _pressedProfessores ? Colors.transparent : Colors.grey.withOpacity(0.5),

                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _changeTemaSentimento(3);

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
                            images[3],
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              textos[3],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /**3ª ROW*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //childAspectRatio: MediaQuery.of(context).size.width /
              //  (MediaQuery.of(context).size.height / 2.6),
              //),
              children: [
                /**CARD ESTUDOS*/
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.width / 3.1,
                    color: _pressedEstudos ? Colors.transparent : Colors.grey.withOpacity(0.5),

                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _changeTemaSentimento(4);

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
                            images[4],
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              textos[4],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(

                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.width / 3.1,
                    color: _pressedColegas ? Colors.transparent : Colors.grey.withOpacity(0.5),

                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _changeTemaSentimento(5);

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
                            images[5],
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              textos[5],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
              width: 20,
            ),
            /*********EMOGIS*********/

            Row(
              children: <Widget>[
                Column(
                  children: [
                    InkWell(

                      onTap: () {
                        setState(() {
                          _changeIcons(1);
                          _registrar(0, usuarioLogado);

                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8.5 ),
                        child:
                        Image.asset(
                          _pressedIconMuitoTriste ? 'assets/images/Triste.png' : 'assets/images/TristeSelected.png',
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 8.5 , top: 5),
                      child: Text(_textoEmogis[0]),
                    )

                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _changeIcons(2);
                          _registrar(1, usuarioLogado);


                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 16),
                        child: Image.asset(
                          _pressedIconTriste ? 'assets/images/Chateado.png': 'assets/images/ChateadoSelected.png',
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 16 , top: 5),
                      child: Text(_textoEmogis[1]),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _changeIcons(3);
                          _registrar(2, usuarioLogado);

                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 16),
                        child: Image.asset(
                          _pressedIconNormal ? 'assets/images/Normal.png': 'assets/images/NormalSelected.png',
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 16 , top: 5),
                      child: Text(_textoEmogis[2]),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _changeIcons(4);
                          _registrar(3, usuarioLogado);


                        });
                       // Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 16),
                        child: Image.asset(
                          _pressedIconFeliz == true ? 'assets/images/Feliz.png': 'assets/images/FelizSelected.png',
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 16 , top: 5),
                      child: Text(_textoEmogis[3]),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(

                      onTap: () {
                        setState(() {
                          _changeIcons(5);
                          _registrar(4, usuarioLogado);


                        });

                        //Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 16),
                        child: Image.asset(
                          _pressedIconMuitoFeliz == true ? 'assets/images/Muito_Feliz.png' : 'assets/images/MuitoFelizSelected.png',
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 16 , top: 5),
                      child: Text(_textoEmogis[4]),
                    )
                  ],
                ),
              ],
            ),
            /*********FIM EMOGIS*********/
          ])
            
            )
          /**END Sentimentos*/



    );



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

    var respostaRepository =  RespostaRepository(await DBHelper.instance.database);

    print("PerguntaTipo: $_perguntaTipo");
    print("Indice Sentimento: $indexSentimento");
    //print("Usuario "+usuarioLogado);
    /**
        Indice Felicidade:

        MUITO_TRISTE = 0,
        TRISTE = 1,
        NORMAL = 2,
        FELIZ = 3,
        MUITO_FELIZ = 4

        Indice Tipod eResposta/Dimenção:

        FAMILIA = 0,
        SAUDE = 1,
        ESCOLA = 2,
        PROFESSORES= 3,
        ESTUDOS = 4,
        COLEGAS = 5
     */
    if(_perguntaTipo == -1) {
      if(!mounted) return;
      Utils.showDefaultSnackbar(context, "Selecione um Tema!!!");
      return;
    }
    var meuEnderecoIp = await Utils.getIpDevice();

    Resposta resposta = Resposta(id: Utils.generateGuide(), turmaId: usuarioLogado.data.turmaId,
                                alunoId: usuarioLogado.data.id, statusEnvio: StatusEnvio.A_ENVIAR.index,
                                erros: "", respostaCodigo: indexSentimento, dataCadastro: Utils.getDataHoraDotNet(),
                                latitude: "2541.332", longitude: "65584,33221", enderecoIp: meuEnderecoIp,
                                perguntaTipo: _perguntaTipo);

   int res = await respostaRepository.add(resposta);

   if(res == 1){
     if(!mounted) return;
     Utils.showDefaultSnackbar(context, "Sentimento salvo");
   }

    ///_perguntaTipo = -1;
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

  /*Future<void> _showDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding:  EdgeInsets.only(left: 8.0, right: 8.0, top: width / 2 , bottom: 10),


          title: const Text('Basic dialog title'),
          content:  Container(
            width: width +20 ,
            height: height - 100 ,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _registrar(0);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Image.asset(
                      'assets/images/Triste.png',
                      height: MediaQuery.of(context).size.width / 10,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _registrar(1);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 16),
                    child: Image.asset(
                      'assets/images/Chateado.png',
                      height: MediaQuery.of(context).size.width / 10,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _registrar(2);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 16),
                    child: Image.asset(
                      'assets/images/Normal.png',
                      height: MediaQuery.of(context).size.width / 10,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _registrar(3);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 16),
                    child: Image.asset(
                      'assets/images/Feliz.png',
                      height: MediaQuery.of(context).size.width / 10,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _registrar(4);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 16),
                    child: Image.asset(
                      'assets/images/Muito_Feliz.png',
                      height: MediaQuery.of(context).size.width / 10,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/
}
