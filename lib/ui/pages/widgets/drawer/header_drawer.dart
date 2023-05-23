import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';

import '../../home_page.dart';
import '../../screen_arguments/screen_arguments_usuario.dart';

class MeuHeadDrawer extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;

  const MeuHeadDrawer(this.usuarioLogado, {Key? key}) : super(key: key);

  @override
  State<MeuHeadDrawer> createState() => _MeuHeadDrawerState();
}

class _MeuHeadDrawerState extends State<MeuHeadDrawer> {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                ///TODO imagem do aluno
                image: AssetImage('assets/images/usuario.png')
              )
            ),
          ),
          Text('''${widget.usuarioLogado?.data.nome ?? ""} ''', style: AppTextStyles.textoSentimentoNegritoWhite(30, context),),
          Text('''${widget.usuarioLogado?.data.email ?? ""}''', style: AppTextStyles.textoSentimentoNegritoWhite(35, context),),

        ],
      ),
    );
  }
}
