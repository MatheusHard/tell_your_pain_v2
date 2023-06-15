
class TurmaDataModel{

  static const String TABELA = "tabelaTurma";
  static const String id = "id";
  static const String escolaId = "escolaId";
  static const String descricao = "descricao";
  static const String dataCadastro = "dataCadastro";
  static const String dataAlteracao = "dataAlteracao";
  static const String ativo = "ativo";



  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $escolaId TEXT, $descricao TEXT, $dataCadastro TEXT,
                                     $dataAlteracao TEXT, $ativo INTEGER);
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
    return '''$TABELA.id, $TABELA.escolaId, $TABELA.descricao, $TABELA.dataCadastro, $TABELA.dataAlteracao, $TABELA.ativo''';
  }
}

