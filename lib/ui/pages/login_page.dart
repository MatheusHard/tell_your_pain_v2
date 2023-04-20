import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/usuario_api.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

import '../api/escola_api.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _senha;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _myFocusNode;
  late FocusNode _myFocusNode_2;

  @override
  void initState (){

    _myFocusNode = FocusNode();
    _myFocusNode_2 = FocusNode();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60,
        child: Image.asset('assets/images/happz.jpg'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator:  (value){
        if(value!.isEmpty || value == ""){
          _myFocusNode.requestFocus();
          return "Digite o Email";
        }
        return null;
      },    );

    final senha = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _senha = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      validator:  (value){
        if(value!.isEmpty || value == ""){
          _myFocusNode.requestFocus();
          return "Digite a Senha";
        }
        return null;
      },
    );

    final botao = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        borderRadius: BorderRadius.circular(32.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {

                if(_formKey.currentState!.validate()) {

                  UsuarioApi(context).loginUsuario(_user(_email, Utils.toSha1(_senha)));
                }

          },
          color: Colors.blueAccent,
          child: const Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final cadastrar = TextButton(
      child: const Text(
        'Não tem uma conta? Cadastre-se',
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
      onPressed: () {
        Navigator.pushNamed(
            context, '/cadastro_page', arguments: null);
        },
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24, right: 24),
          children: [
            logo,
            const SizedBox(
              height: 48.0,
            ),
            email,
            const SizedBox(
              height: 8.0,
            ),
            senha,
            const SizedBox(
              height: 24.0,
            ),
            botao,
            cadastrar
          ],
        ),
      ),
     )
    );



  }

  _user(String email, String senha){

    return {
      "email": email,
      "senha": senha,
      "token": "",
      "foto": "string",
      "nome": "string",
      "dataNascimento": "2023-04-16T14:50:12.626Z",
      "telefone": "string",
      "escolaId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "turmaId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "tipoUsuarioId": 0,
      "cpf": "string",
      "nomeResponsavel": "string",
      "cpfResponsavel": "string",
      "telefoneResponsavel": "string",
      "dataCadastro": "2023-04-16T14:50:12.626Z",
      "dataAlteracao": "2023-04-16T14:50:12.626Z",
      "rua": "string",
      "numeroCasa": "string",
      "complemento": "string",
      "cidadeId": 0,
      "bairroId": 0
    };
  }

}
