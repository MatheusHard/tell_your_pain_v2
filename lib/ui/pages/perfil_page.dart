import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

class PerfilPage extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;

  const PerfilPage(this.usuarioLogado, {Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  ScreenArgumentsUsuario? usuarioLogado;

  @override
  void initState() {
    usuarioLogado = widget.usuarioLogado;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: _appBar(width, usuarioLogado, "como se sente?"),
      body: Center(
        child: Container(
          height: height / 1.5,
          width: width / 1.2,
          decoration: BoxDecoration(
              gradient: AppGradients.buttonSentimento,
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )

              ]

          ),
          child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Utils.sizedBox(20, 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  Image.asset(
                ///TODO Imagem do usuario
                'assets/images/usuario.png',
                height: MediaQuery.of(context).size.width / 5,
                //   width: MediaQuery.of(context).size.width / 10,
              ),
            ),
            Utils.sizedBox(20, 20),
            Text('''${usuarioLogado?.data.nome}''', style: AppTextStyles.titleCardBlack(15, context),),
            Utils.sizedBox(20, 20),
            Text('''Cpf: ${usuarioLogado?.data.cpf}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''E-mail: ${usuarioLogado?.data.email}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Nascido: ${Utils.formatarData(usuarioLogado?.data.dataNascimento, true) }''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Fone: ${usuarioLogado?.data.telefone}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Escola: ${usuarioLogado?.data.escola.nome}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),
            Text('''Turma: ${usuarioLogado?.data.turma.descricao}''', style: AppTextStyles.titleCardBlack(30, context),),
            Utils.sizedBox(20, 20),


            /**
             *  'id': id,
                'nome': nome,
                'cpf': cpf,
                'email': email,
                // 'senhaHash':  senhaHash,
                'dataNascimento': dataNascimento,
                'escolaId': escolaId,
                'turmaId': turmaId,
                'foto': foto,
                'telefone': telefone
             * **/
          ],
        ),
      ),
     )
    )
    ;
  }

  _appBar(double width, ScreenArgumentsUsuario? usuarioLogado, String texto){

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
                  Text('''Perfil''' , style: AppTextStyles.titleAppBarUsuario(25, context),),

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
}
