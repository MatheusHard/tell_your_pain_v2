
class RespostaDataModel{

  static const String TABELA = "tabelaResposta";
  static const String id = "id";
  static const String dataCadastro = "dataCadastro";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String enderecoIp = "enderecoIp";
  static const String turma = "turma";
  static const String alunoId = "alunoId";
  static const String statusEnvio = "statusEnvio";
  static const String erros = "erros";
  static const String respostaCodigo = "respostaCodigo";
  static const String perguntaTipo = "perguntaTipo";


  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $dataCadastro TEXT, $latitude TEXT, $longitude TEXT, $enderecoIp TEXT,
                                    $turma INTEGER, $alunoId TEXT, $statusEnvio INTEGER, $erros TEXT, $respostaCodigo INTEGER,
                                    $perguntaTipo INTEGER);
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

