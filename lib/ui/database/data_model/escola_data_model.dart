
class EscolaDataModel{

  static const String TABELA = "tabelaEscola";
  static const String id = "id";
  static const String nome = "nome";
  static const String cnpj = "cnpj";
  static const String cidadeId = "cidadeId";
  static const String bairroId = "bairroId";
  static const String rua = "rua";
  static const String telefone = "telefone";
  static const String dataCadastro = "dataCadastro";
  static const String dataAlteracao = "dataAlteracao";

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $nome TEXT, $cnpj TEXT, $cidadeId INTEGER, $bairroId INTEGER,
                                    $rua TEXT, $telefone TEXT, $dataCadastro TEXT, $dataAlteracao TEXT);
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

