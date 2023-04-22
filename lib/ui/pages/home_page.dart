import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/appbar/app_bar_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/bar_chart.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return Scaffold(
     // extendBodyBehindAppBar: true,

      appBar: AppBarUsuario(usuarioLogado,  "", context),

      backgroundColor: const Color(0xFFF0F0F0),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: AppGradients.petMacho
        ),
        child: CurvedNavigationBar(

          //type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items:  [
            _curvedButton( 'assets/images/icones_home/home.png', "Home", 60),
            _curvedButton('assets/images/icones_home/historico.png', "Histórico", 60),
            _curvedButton( 'assets/images/icones_home/user.png', "Perfil", 60),
          ],
          color: Colors.transparent,
          backgroundColor: Colors.transparent,

          buttonBackgroundColor:  Colors.transparent,
          animationCurve: Curves.easeInCubic,
          animationDuration: const Duration(milliseconds: 600),
          /*BottomNavigationBarItem(
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
                label:'Perfil'),*/

        ),
      ),
      // body: getBody(),
      body: tabs[_currentIndex],
    );
  }

  getBody() {
    return (_currentIndex == 0) ? MainPage() : Container();
  }

  final tabs = [

    MainPage(),
    const Center(child: Text("HISTORICO")),
    BarChart()
  ];


  _curvedButton(String url, String texto, int numero){
    return  Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Image.asset(
            url,
            width: 40,
            height: 40,
          ),
          Text(texto, style: TextStyle(fontSize: MediaQuery.of(context).size.width / numero))
        ],
      ),
    );
  }
}
