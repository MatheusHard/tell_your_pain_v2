import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/chat_management.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  var chat = {
    'texto': 'msg',
    'imgUrl': 'imgUrl',
    'sender': 'nome',
    'createdAt': DateTime.now()
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat da Turma"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.4,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
               /* stream: Firestore.instance
                    .collection('turmas')
                    .document('F4RVf2v1vivekFl7APHr')
                    .collection('mensagens')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),*/
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                       //  List r = snapshot.data?.documents.toList();
                         // return ChatMessage(r[index].data);
                          return ChatMessage(chat);
                        },
                      //  itemCount: snapshot.data?.documents.length,
                      );
                  }
                },
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();
  bool _isComposing = true;
  final ChatManagement _chatManagement = ChatManagement();

  void _reset() {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  void _enviarMsg({ String? msg,  String? imgUrl}) async {
    /*FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(user.uid).get();
    String nome = doc.data['nome'];

    Firestore.instance
        .collection('turmas')
        .document('F4RVf2v1vivekFl7APHr')
        .collection('mensagens')
        .add({
      'texto': msg,
      'imgUrl': imgUrl,
      'sender': nome,
      'createdAt': Timestamp.now()
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)))
            : null,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.photo_camera),
              onPressed: () async {
              /*  File imgFile =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                if (imgFile == null) return;
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                StorageUploadTask task = FirebaseStorage.instance
                    .ref()
                    .child(user.uid +
                        DateTime.now().millisecondsSinceEpoch.toString())
                    .putFile(imgFile);
                var dowurl =
                    await (await task.onComplete).ref.getDownloadURL();
                String url = dowurl.toString();
                _enviarMsg(imgUrl: url);*/
              },
            ),
            Expanded(
              child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Enviar uma Mensagem"),
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: (nome) {
                    _reset();
                    _enviarMsg(msg: nome);
                  }),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        onPressed: _isComposing
                            ? () {
                                _enviarMsg(msg: _textController.text);
                                _reset();
                              }
                            : null,
                        child: const Text('Enviar'),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _isComposing
                            ? () {
                                _enviarMsg(msg: _textController.text);
                                _reset();
                              }
                            : null,
                      )),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ChatMessage(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/icones_home/usuario.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['sender'],
                  //style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: data['imgUrl'] != null
                        ? Image.network(
                            data['imgUrl'],
                            width: 250.0,
                          )
                        : Text(data['texto'])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
