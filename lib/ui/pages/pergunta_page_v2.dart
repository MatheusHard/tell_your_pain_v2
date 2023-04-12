
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';

class PerguntaPage2 extends StatefulWidget {
  const PerguntaPage2({Key? key}) : super(key: key);

  @override
  State<PerguntaPage2> createState() => _PerguntaPage2State();
}

class _PerguntaPage2State extends State<PerguntaPage2> {

  bool flagColor = true;
  bool _pressed = true;
  bool _pressedIconMuitoFeliz = true;
  bool _pressedIconFeliz = true;
  bool _pressedIconNormal = true;
  bool _pressedIconTriste = true;
  bool _pressedIconMuitoTriste = true;


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

             GridView.builder(
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
      ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: [
                    InkWell(

                      onTap: () {
                        setState(() {
                          _registrar(0);
                          _changeIcons(1);

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
                          _registrar(1);
                          _changeIcons(2);

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
                          _registrar(2);
                          _changeIcons(3);

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
                          _registrar(3);
                          _changeIcons(4);

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
                          _registrar(4);
                          _changeIcons(5);

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


               ])
            
            )
          /**END Sentimentos*/



    );



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
  void _registrar(int index) async {
   print("Indice $index");
  }
  _changeColor(){

    var cor;


    return cor;

  }
  Future<void> _showDialogBuilder(BuildContext context) {
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
                    padding: EdgeInsets.only(
                      // left: MediaQuery.of(context).size.width / 60),
                        left: 0),
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
  }
}
