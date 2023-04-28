import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_colors.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/appbar/app_bar_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/column_chart.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/charts.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    ScreenArgumentsUsuario? usuarioLogado = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsUsuario?;

    return WillPopScope(
      onWillPop: ()  async {
        print("Preciosou voltar");
        _moveToLogin(context);
        return true;

      },
      child: Scaffold(
       // extendBodyBehindAppBar: true,

        appBar: AppBarUsuario(usuarioLogado,  "", context),

        backgroundColor: AppColors.red,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),

         color: Colors.transparent,
          child: CurvedNavigationBar(

            //type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items:  [
              /*_curvedButton( 'assets/images/icones_home/home.png', "Home", 60),
              _curvedButton('assets/images/icones_home/historico.png', "Histórico", 60),
              _curvedButton( 'assets/images/icones_home/user.png', "Perfil", 60),*/
              Icon(Icons.account_circle_rounded, size: width / 16, color: Colors.grey,),
              Icon(Icons.ondemand_video_rounded, size: width / 16, color: Colors.grey,),
              Icon(Icons.insert_chart_outlined_rounded, size: width / 16, color: Colors.grey,),
            ],
            color: AppColors.white,
            buttonBackgroundColor: AppColors.white,
            backgroundColor:AppColors.levelButtonTextFacil,
            animationCurve: Curves.easeInCubic,
            animationDuration: const Duration(milliseconds: 400),

            index: 0,
            height: 50,

          ),
        ),
        // body: getBody(),
        body: tabs[_currentIndex],
      ),
    );
  }

  getBody() {
    return (_currentIndex == 0) ? MainPage() : Container();
  }
  void _moveToLogin(BuildContext context) =>
      Navigator.pushNamed(
          context, '/login_page', arguments: null);

  final tabs = [

    MainPage(),
    Padding( padding:  const EdgeInsets.only( left:8.0, right: 8.0), child: Container(  color: AppColors.levelButtonTextFacil,)),
    const ChartsPage()
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
