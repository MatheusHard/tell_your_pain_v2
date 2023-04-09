import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/usuario_api.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/metods/utils.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _senha;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    );

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
            var user =  {
              "Email": "matheus@gmail.com",
              "Nome": "Luiz Silva",
              "Password": "1254",
              "Cpf": "05698754521",
              "Fone" : "05698754521",
              "Foto" : "fgff/ggh"
            };
//UsuarioApi().getJson();
            UsuarioApi(context).loginUsuario(user);

            /*FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: _email,
              password: _senha,
            )
                .then((user) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/pages/home_page');
            }).catchError((e) {
              Utils.showDefaultSnackbar(context, 'Email ou Senha Inválido');



            });*/
          },
          color: Colors.blueAccent,
          child: const Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final cadastrar = FloatingActionButton(
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
    );
  }
}
