
class RecursoDataModel{

  static const String TABELA = "tabelaRecurso";
  static const String id = "id";
  static const String link = "link";
  static const String tipoRecurso = "tipoRecurso";
  static const String indicacao = "indicacao";
  static const String intervaloInicial = "intervaloInicial";
  static const String intervaloFinal = "intervaloFinal";
  static const String dataCadastro = "dataCadastro";
  static const String dataAlteracao = "dataAlteracao";
  static const String ativo = "ativo";

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $link TEXT, $tipoRecurso INTEGER, $indicacao TEXT,
                                     $intervaloInicial REAL, $intervaloFinal REAL, $dataCadastro TEXT,
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

