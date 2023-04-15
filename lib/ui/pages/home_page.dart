import 'package:flutter/material.dart';

import 'main_page.dart';

class HomePage extends StatelessWidget {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAppy'),
      ),
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
