
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';

class PerguntaPage2 extends StatefulWidget {
  const PerguntaPage2({Key? key}) : super(key: key);

  @override
  State<PerguntaPage2> createState() => _PerguntaPage2State();
}

class _PerguntaPage2State extends State<PerguntaPage2> {


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


  @override
  Widget build(BuildContext context) {

    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return Scaffold(
        appBar: AppBar(
          title:  Text('''Olá ${usuarioLogado != null ? usuarioLogado?.data.nome: ""}, como se sente?'''),
        ),


        body:

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
                  child: InkWell(
                    onTap: () async {
                      int? indice = index;
                      print("INDICE $indice");
                      _showDialogBuilder(context);

//                click(index, context, usuarioLogado?.data);

                    },
                    child: Column(
                      children: <Widget>[
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
                );

            },
      ),
          /**END Sentimentos*/



    );



  }

  Future<void> _showDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text('A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.'),
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
