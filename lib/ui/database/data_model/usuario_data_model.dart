
class UsuarioDataModel{

  static const String TABELA = "tabelaUsuario";
  static const String id = "id";
  static const String nome = "nome";
  static const String cpf = "cpf";
  static const String email = "email";
  static const String foto = 'foto';
  static const String telefone = 'telefone';
  static const String dataNascimento = 'dataNascimento';
  static const String responsavelId = 'responsavelId';
  static const String turmaId = 'turmaId';
  static const String enderecoId = 'enderecoId';



  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $nome TEXT, $cpf TEXT, $email TEXT,
                                    $foto TEXT, $telefone TEXT, $dataNascimento TEXT,
                                    $responsavelId TEXT, $turmaId TEXT, $enderecoId TEXT);
           ''';
        }

  static String dropTable(){
    return   "DROP TABLE IF EXISTS $TABELA;";
  }

  static String zerarTabela() {

    return "DELETE FROM $TABELA;";
  }

  static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
    return '''$TABELA.id, $TABELA.nome, $TABELA.user, $TABELA.password, $TABELA.qtdRowListagem, $TABELA.cpf, $TABELA.codigoRecuperacao''';
  }
}

