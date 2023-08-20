import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/escola_api.dart';
import 'package:tell_your_pain_v2/ui/pages/perfil_page.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_colors.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/appbar/app_bar_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/column_chart.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/charts/charts.dart';
import 'package:tell_your_pain_v2/ui/pages/widgets/drawer/header_drawer.dart';

import '../api/resposta_api.dart';
import '../api/turma_api.dart';
import '../enums/drawer_sections.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key

  @override
  void initState() {
    _enviarRespostasApi();
    super.initState();
  }
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
        key: key,
        //drawerEnableOpenDragGesture: false,
        // extendBodyBehindAppBar: true,
        appBar: _appBar(width, usuarioLogado),
        //appBar: AppBarUsuario(usuarioLogado,  "", context),
        drawer:
         Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Header Drawer
                MeuHeadDrawer(usuarioLogado),
                ///Body Drawer
                _meuDrawerList(usuarioLogado),
              ],
            ),
          )
        ),

        backgroundColor: AppColors.red,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          color: Colors.transparent,
          child: CurvedNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items:  [
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

  _appBar(double width, ScreenArgumentsUsuario? usuarioLogado){

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
            ///Nome
            SizedBox(
              height: (MediaQuery.of(context).size.width / 10) - 17,
              // width: MediaQuery.of(context).size.width / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('''Olá ${usuarioLogado?.data.nome}''' , style: AppTextStyles.titleAppBarUsuario(25, context),),
                ],),
            )


          ],
        ),
        _sizedBox(10)
      ],
      leadingWidth: 220,
      leading: GestureDetector(
        onTap: () => key.currentState!.openDrawer(),
        ///key.currentState?.openEndDrawer();
        child:  Row(
          children:  [
            _sizedBox(10),
            const Icon(Icons.menu, color: Colors.white),
          ],
        ),
      ),
    );
  }
  ///MenuDrawer:
  _meuDrawerList(ScreenArgumentsUsuario? usuario){
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(0, "DashBoard", Icons.dashboard_outlined, currentPage == DrawerSections.dashboard ? true : false, usuario),
          menuItem(1, "Perfil", Icons.person, currentPage == DrawerSections.perfil ? true : false, usuario),
          const Divider(),
          menuItem(2, "Sair", Icons.exit_to_app, currentPage == DrawerSections.exit ? true : false, usuario),

        ],
      ),
    );
  }
  ///Menu Item:
  menuItem(int id, String title, IconData icon, bool selected, ScreenArgumentsUsuario? usuario){
    return Material(
      color: selected ? Colors.grey[300]: Colors.transparent,
      child: InkWell(
        onTap: (){

          Navigator.pop(context);
          setState(() {
            switch(id){
              case 0:
                currentPage = DrawerSections.dashboard;
                break;
              case 1:
                currentPage = DrawerSections.perfil;
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PerfilPage(usuario)));
                break;
              case 2:
                currentPage = DrawerSections.exit;
                break;
            }

          });
        },
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
            children:  [
              Expanded(child: Icon(icon, size: 20, color: Colors.black,),),
              Expanded(flex: 3, child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 16),))
          ],
        )),
        
      )
    );
  }
  _sizedBox(double width){
    return SizedBox(
      width: width,
    );
  }
  _enviarRespostasApi() async{

    var lista = [];
    if(await Utils.isConnected()) RespostaApi(context).enviarRespostas(lista);

  }


}



