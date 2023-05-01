
import 'package:flutter/material.dart';

import 'package:tell_your_pain_v2/ui/pages/screen_arguments/ScreenArgumentsUsuario.dart';

import '../../utils/core/app_gradients.dart';
import '../../utils/core/app_text_styles.dart';

class AppBarUsuario extends PreferredSize {
  AppBarUsuario(ScreenArgumentsUsuario? args, String texto, BuildContext context, {Key? key}):super(key: key,

    preferredSize: const Size.fromHeight(200),

    child: Container(

      height: 130,
      decoration:  const BoxDecoration(
        gradient: AppGradients.petMacho,
        color: Colors.orange,
        boxShadow:  [
          BoxShadow(blurRadius: 50.0)
        ],
       /* borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical( MediaQuery.of(context).size.width, 100.0)),*/
      ),

      //  gradient:  AppGradients.petMacho,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

         /* IconButton(
            icon: Icon(Icons.menu),
            // call toggle from SlideDrawer to alternate between open and close
            // when pressed menu button
            onPressed: () {
              ///SlideDrawer.of(context)?.toggle()
              print('menuBar');
            },
          ),*/
        ///Foto:
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:  Image.asset(
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
                Text('''Olá ${args?.data.nome} $texto''' , style: AppTextStyles.titleAppBarUsuario(25, context),),

              ],),
          )

        ],
      ),
    ),
  );

}
