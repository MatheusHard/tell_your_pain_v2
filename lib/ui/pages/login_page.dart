import 'package:flutter/material.dart';
import 'package:tell_your_pain_v2/ui/api/usuario_api.dart';
import 'package:tell_your_pain_v2/ui/pages/utils/core/app_gradients.dart';
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
  bool isChecked = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _myFocusNode;
  final textFieldFocusNode = FocusNode();

  bool obscured = true;
  bool _isLoading = false;


  @override
  void initState (){

    _myFocusNode = FocusNode();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    ///Mudar cor do CheckBOx:
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }


    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    final logo = Hero(
        tag: 'hero',
        child:

        Padding(
          padding: const EdgeInsets.all(35),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  )]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/happz.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),         // No border
          borderRadius: BorderRadius.circular(12),  // Apply corner radius
        ),
        prefixIcon: const Icon(Icons.alternate_email, color: Colors.blue,),

        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
      obscureText: obscured,
      focusNode: textFieldFocusNode,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) {
        setState(() {
          _senha = value;
        });
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: "Senha",
        filled: true, // Needed for adding a fill color
        fillColor: Colors.white60,
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),         // No border
          borderRadius: BorderRadius.circular(12),  // Apply corner radius
        ),
        prefixIcon: const Icon(Icons.lock_rounded, size: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              obscured
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 24,
            ),
          ),
        ),
      ),
      validator:  (value){
        if(value!.isEmpty || value == ""){
          _myFocusNode.requestFocus();
          return "Digite a Senha";
        }
        return null;
      },
    );

    final botao = GestureDetector(

      onTap: ()  {

        if(isChecked){
          if(_formKey.currentState!.validate()) {
            _isLoading ? null : _startLoading();
            setState(() {
              _isLoading = false;
            });
          }
        }else{
          Utils.showDefaultSnackbar(context, "Aceite os termos!!!");
        }

      },
      child:   Container(

        height: 60,
        decoration: BoxDecoration(
            gradient: AppGradients.petMacho,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )

            ]

        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            _isLoading
                   ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator())
                   : const Icon(Icons.account_circle_rounded, color: Colors.white, size: 25),

            const SizedBox(
              width: 15,
            ),
            Text( _isLoading ? 'Carregando':'Log In',textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    final termosConsentimento = Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),

        TextButton(

          child: const Text(

            'Aceite os Termos',

            style: TextStyle(color: Colors.blue, fontSize: 16),

          ),

          onPressed: () {
            _dialogAceiteosTermos(context);

          },

        )

      ],


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
                _sizedBox(48.0),
                email,
                _sizedBox(15.0),
                senha,
                _sizedBox(24.0),
                botao,
                termosConsentimento,
                ///cadastrar
              ],
            ),
          ),
        )
    );

  }
  void _toggleObscured() {
    setState(() {
      obscured = !obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  ///Loading Icon and Text:
  void _startLoading() async {

    //await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = true;
      UsuarioApi(context).loginUsuario(_user(_email, Utils.toSha1(_senha)));
    });
//    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

  }

  _sizedBox(double height){
    return SizedBox(
      height: height,
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

  Future<void> _dialogAceiteosTermos(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Termo de Consentimento')),
          content: const SingleChildScrollView(
            child: Text(''''|. O atendimento a distância é limitado por não permitir a realização do exame físico presencial.
          Poderão ser executadas algumas manobras de tele propedêutica, que é o exame físico à distância. Por isso é ainda mais importante informar todos os dados e informações possíveis, não omitindo nenhuma informação referente ao problema de saúde, colaborando assim para o bom aproveitamento desta consulta;

          Il. Poderá ser necessário, a critério do médico, a realização de exames complementares para auxiliar no diagnóstico;
. O atendimento a distância é limitado por não permitir a realização do exame físico presencial.
          Poderão ser executadas algumas manobras de tele propedêutica, que é o exame físico à distância. Por isso é ainda mais importante informar todos os dados e informações possíveis, não omitindo nenhuma informação referente ao problema de saúde, colaborando assim para o bom aproveitamento desta consulta;

          Il. Poderá ser necessário, a critério do médico, a re
          . O atendimento a distância é limitado por não permitir a realização do exame físico presencial.
          Poderão ser executadas algumas manobras de tele propedêutica, que é o exame físico à distância. Por isso é ainda mais importante informar todos os dados e informações possíveis, não omitindo nenhuma informação referente ao problema de saúde, colaborando assim para o bom aproveitamento desta consulta;

          Il. Poderá ser necessário, a critério do médico, a re
          . O atendimento a distância é limitado por não permitir a realização do exame físico presencial.
          Poderão ser executadas algumas manobras de tele propedêutica, que é o exame físico à distância. Por isso é ainda mais importante informar todos os dados e informações possíveis, não omitindo nenhuma informação referente ao problema de saúde, colaborando assim para o bom aproveitamento desta consulta;

          Il. Poderá ser necessário, a critério do médico, a re
        '''),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
