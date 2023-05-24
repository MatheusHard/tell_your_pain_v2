
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_you_tube.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePage extends StatefulWidget {
  final ScreenArgumentsUsuario? usuarioLogado;
  final url;

  const YouTubePage(this.usuarioLogado, this.url, {Key? key}) : super(key: key);
  @override
  State<YouTubePage> createState() => _YouTubePageState();
}

class _YouTubePageState extends State<YouTubePage> {

  late YoutubePlayerController _controller;
  ScreenArgumentsUsuario? usuarioLogado;


  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: true
      )
    )..addListener(() {
      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    usuarioLogado = widget.usuarioLogado;

    runYoutubePlayer();
    super.initState();
  }
  @override
  void dispose() {
  _controller.dispose();
  super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                            controller: _controller),
                  builder: (context, player){
                    return Scaffold(
                      appBar: _appBar(width, usuarioLogado, "como se sente?"),
                    body: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                    Container(
                                        decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.5),
                                            spreadRadius: 4,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          )

                                        ],),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: player
                                      ),
                                    ),
                        
                               Utils.sizedBox(5, 5),
                               Text('''Titulo: ${_controller.metadata.title}''', style: AppTextStyles.titleCardBlack(28, context),),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text('''Autor: ${_controller.metadata.author}''',
                                       style: AppTextStyles.titleCardBlack(35, context),),
                                   Text('''Duração: ${Utils.prettyDuration(_controller.metadata.duration)}''',
                                        style: AppTextStyles.titleCardBlack(35, context),),
                                 ],
                               )


                            ],

                        ),
                    ),

                    );
                  });
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
            Utils.sizedBox(width /10,0),
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
            Utils.sizedBox(25,0),
            ///NOme
            SizedBox(
              height: (MediaQuery.of(context).size.width / 10) - 17,
              // width: MediaQuery.of(context).size.width / 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('''Video''' , style: AppTextStyles.titleAppBarUsuario(25, context),),

                ],),
            )

          ],
        ),
        Utils.sizedBox(10, 0)
      ],
      //leadingWidth: 220,

    );
  }
}
