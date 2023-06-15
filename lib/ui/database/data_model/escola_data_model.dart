
class EscolaDataModel{

  static const String TABELA = "tabelaEscola";
  static const String id = "id";
  static const String nome = "nome";
  static const String cnpj = "cnpj";
  static const String telefone = "telefone";
  static const String dataCadastro = "dataCadastro";
  static const String dataAlteracao = "dataAlteracao";
  static const String poloId = "poloId";
  static const String email = "email";
  static const String enderecoId = "enderecoId";
  static const String ativo = "ativo";


  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY, $nome TEXT, $cnpj TEXT,  $telefone TEXT,
                                    $dataCadastro TEXT, $dataAlteracao TEXT, $poloId TEXT,
                                    $email TEXT, $enderecoId TEXT, $ativo INTEGER);
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

