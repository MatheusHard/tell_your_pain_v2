
class ConsumoRecursoDataModel{

  static const String TABELA = "tabelaConsumoRecurso";
  static const String id = "id";
  static const String usuarioId = "usuarioId";
  static const String recursoId = "recursoId";
  static const String dataCadastro = "dataCadastro";
  static const String respostaCodigo = "respostaCodigo";




  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $usuarioId TEXT, $recursoId TEXT,
                                     $dataCadastro TEXT, $respostaCodigo INTEGER);
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

