
import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_usuario.dart';
import 'package:tell_your_pain_v2/ui/pages/screen_arguments/screen_arguments_you_tube.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_text_styles.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/core.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../enums/resposta_codigo.dart';

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
  bool _pressedIconMuitoFeliz = true;
  bool _pressedIconFeliz = true;
  bool _pressedIconNormal = true;
  bool _pressedIconTriste = true;
  bool _pressedIconMuitoTriste = true;
  ///
  bool _isPlaying = false;
  late PlayerState _playerState;
  bool _isPlayerReady = false;

  final _textoEmogis = Utils.textoEmogisYouTube();

  late YoutubeMetaData _videoMetaData;


  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
        flags: const YoutubePlayerFlags(
            enableCaption: false,
            isLive: false,
            loop: false,
            autoPlay: true
        )

    )
      ..addListener(listener);
      _playerState = PlayerState.unknown;
      _videoMetaData = const YoutubeMetaData();
   }

    void listener() {
      if (mounted && !_controller.value.isFullScreen) {
        setState(() {
          _playerState = _controller.value.playerState;
          _videoMetaData = _controller.metadata;
        });
      }
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
                    onReady: () {
                      _isPlayerReady = true;
                    },
                    onEnded: (data) {
                      Utils.showDefaultSnackbar(context, 'O que achou do Video?');

                      _isPlaying = true;
                    },
                    showVideoProgressIndicator: true,
                    controller: _controller
                              ..addListener(() {
                                if (_controller.value.isPlaying) {
                                  setState(() {
                                    print("Tocando");
                                   // _isPlaying = true;
                                  });
                                  } else {
                                  setState(() {
                                    print("Parou");
                                   // _isPlaying = false;
                                  });

                                  }

                              }),
                            ),
                            builder: (context, player){
                                return Scaffold(
                                  appBar: _appBar(width, usuarioLogado, "como se sente?"),
                                body: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: _columnYouTube(player, width, height)
                            ),
                         );
                       });
  }

  _columnYouTube(Widget player, var width, var height){

    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Padding(
          padding: const EdgeInsets.only(left:  8.0, right: 8.0),
          child: Text('''Titulo: ${_controller.metadata.title}''', style: AppTextStyles.titleCardBlack(32, context),),
        ),
        Padding(
          padding: const EdgeInsets.only(left:  8.0, right: 8.0),
          child: Text('''Autor: ${_controller.metadata.author}''',
            style: AppTextStyles.subTitleCardBlack(35, context),),
        ),
        Padding(
          padding: const EdgeInsets.only(left:  8.0, right: 8.0),
          child: Text('''Duração: ${Utils.prettyDuration(_controller.metadata.duration)}''',
            style: AppTextStyles.subTitleCardBlack(35, context),),
        ),

        Utils.sizedBox(10, 5),

        ///Locais dos votos:
        _isPlaying ? Container(
          decoration: BoxDecoration(
            gradient: AppGradients.petMacho,
            borderRadius: BorderRadius.circular(20),
              boxShadow:const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                )]
          ),
          child: Column(
            children: [
              Utils.sizedBox(20, 5),

              Center(
                child: Text('''O que achou do Video?''',
                  style: AppTextStyles.titleCardWhite(27, context),),
                ),
              Padding(
                padding: EdgeInsets.only(top:  width / 20, left:  width / 15, right: width / 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Emogi Muito Triste
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changeIcons(RespostaCodigo.MUITO_TRISTE.index);
                              _registrar(RespostaCodigo.MUITO_TRISTE.index, usuarioLogado);
                            });
                          },
                          child: Image.asset(
                            _pressedIconMuitoTriste ? 'assets/images/Triste.png' : 'assets/images/TristeSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                        Text( _textoEmogis[0], style: AppTextStyles.subTitleGeneric(35, width, AppColors.white, FontWeight.normal))
                      ],
                    ),
                    ///Emogi Triste
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changeIcons(RespostaCodigo.TRISTE.index);
                              _registrar(RespostaCodigo.TRISTE.index, usuarioLogado);
                            });
                          },
                          child: Image.asset(
                            _pressedIconTriste ? 'assets/images/Chateado.png': 'assets/images/ChateadoSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                        Text(_textoEmogis[1], style: AppTextStyles.subTitleGeneric(35, width, AppColors.white, FontWeight.normal))
                      ],
                    ),
                    ///Emogi Normal
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changeIcons(RespostaCodigo.NORMAL.index);
                              _registrar(RespostaCodigo.NORMAL.index, usuarioLogado);
                            });
                          },
                          child: Image.asset(
                            _pressedIconNormal ? 'assets/images/Normal.png': 'assets/images/NormalSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                        Text(_textoEmogis[2], style: AppTextStyles.subTitleGeneric(35, width, AppColors.white, FontWeight.normal))
                      ],
                    ),
                    ///Emogi Feliz
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changeIcons(RespostaCodigo.FELIZ.index);
                              _registrar(RespostaCodigo.FELIZ.index, usuarioLogado);
                            });
                            // Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            _pressedIconFeliz == true ? 'assets/images/Feliz.png': 'assets/images/FelizSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                        Text(_textoEmogis[3], style: AppTextStyles.subTitleGeneric(35, width, AppColors.white, FontWeight.normal))
                      ],
                    ),
                    ///Emogi Muito Feliz
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changeIcons(RespostaCodigo.MUITO_FELIZ.index);
                              _registrar(RespostaCodigo.MUITO_FELIZ.index, usuarioLogado);
                            });

                            //Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            _pressedIconMuitoFeliz == true ? 'assets/images/Muito_Feliz.png' : 'assets/images/MuitoFelizSelected.png',
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                        Text(_textoEmogis[4] ,style: AppTextStyles.subTitleGeneric(35, width, AppColors.white, FontWeight.normal))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) : Container()
      ],
    );
  }
  void _registrar(int indexSentimento, var usuarioLogado) async {

    var geoLocalizacao = await Utils.getGeolocalizacao();


  }
  TextStyle _estiloEmogis(var numero){

    return TextStyle(fontSize: MediaQuery.of(context).size.width / numero);
  }
  _changeIcons(int numero){

    switch(numero){
      case 1:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = true;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = !_pressedIconMuitoTriste;
        break;
      case 2:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = true;
        _pressedIconTriste = !_pressedIconTriste;
        _pressedIconMuitoTriste = true;
        break;
      case 3:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = true;
        _pressedIconNormal = !_pressedIconNormal;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = true;
        break;
      case 4:
        _pressedIconMuitoFeliz = true;
        _pressedIconFeliz = !_pressedIconFeliz;
        _pressedIconNormal = true;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = true;
        break;
      case 5:
        _pressedIconMuitoFeliz = !_pressedIconMuitoFeliz;
        _pressedIconFeliz = true;
        _pressedIconNormal = true;
        _pressedIconTriste = true;
        _pressedIconMuitoTriste = true;
        break;
    }
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
            ///Nome
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
