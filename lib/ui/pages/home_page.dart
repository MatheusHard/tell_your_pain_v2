import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/appbar/app_bar_usuario.dart';

import 'main_page.dart';

class HomePage extends StatelessWidget {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBarUsuario(usuarioLogado,  "", context),

      backgroundColor: const Color(0xFFF0F0F0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icones_home/home.png',
                width: 40,
                height: 40,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icones_home/historico.png',
                width: 40,
                height: 40,
              ),
              label: 'Histórico'),
          BottomNavigationBarItem(
              icon: Image.asset(

                'assets/images/icones_home/user.png',
                width: 40,
                height: 40,
              ),
              label:'Perfil'),
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return (_currentIndex == 0) ? MainPage() : Container();
  }
}
