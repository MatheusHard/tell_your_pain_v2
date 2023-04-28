
class RespostaDataModel{

  static const String TABELA = "tabelaResposta";
  static const String id = "id";
  static const String dataResposta = "dataResposta";
  static const String geoReferenciamento = "geoReferenciamento";
  static const String enderecoIp = "enderecoIp";
  static const String escolaId = "escolaId";
  static const String usuarioId = "usuarioId";
  static const String poloId = "poloId";
  static const String statusEnvio = "statusEnvio";
  static const String erros = "erros";
  static const String respostaCodigo = "respostaCodigo";
  static const String dimensaoId = "dimensaoId";
  static const String turmaId = "turmaId";


  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $dataResposta TEXT, $geoReferenciamento TEXT, $enderecoIp TEXT,
                                    $escolaId TEXT, $usuarioId TEXT, $statusEnvio INTEGER, $erros TEXT, $respostaCodigo INTEGER,
                                    $dimensaoId INTEGER, $poloId TEXT, $turmaId TEXT);
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

