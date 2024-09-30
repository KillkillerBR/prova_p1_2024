import 'package:novo_projeto/entidade/pessoa.dart';
import 'package:novo_projeto/repositorio/Dao.dart';

class PessoaController {
  Dao _dao = Dao();
  salvar(Pessoa p) {
    _dao.add(p);
  }

  remover(Pessoa p) {
    _dao.remove(p);
  }

  List listar() {
    return _dao.dados;
  }
}