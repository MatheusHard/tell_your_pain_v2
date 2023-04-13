
class UsuarioDataModel{

  static const String TABELA = "tabelaUsuario";
  static const String id = "id";
  static const String nome = "nome";
  static const String cpf = "cpf";
  static const String email = "email";
  static const String password = "password";
  static const String escolaId = "escolaId";
  static const String turmaId = 'turmaId';
  static const String foto = 'foto';
  static const String fone = 'fone';
  static const String dataDeNascimento = 'dataDeNascimento';

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY,
                                    $nome TEXT, $cpf TEXT, $email TEXT, $turmaId TEXT,
                                    $password TEXT, $dataDeNascimento TEXT, $escolaId TEXT,
                                    $foto TEXT, $fone TEXT);
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
