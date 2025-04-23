import 'package:lista_compras_mobile/models/produto.dart';

class ProdutoRepository{
  static List<Produto> tabela = [
    Produto(
      nome: 'Arroz',
      quantidade: '2Kg',
      isComprado: false
    ),
    Produto(
      nome: 'Feijão',
      quantidade: '1Kg',
      isComprado: false
    ),
    Produto(
      nome: 'Macarrão',
      quantidade: '500g',
      isComprado: false
    ),
    Produto(
      nome: 'Óleo',
      quantidade: '1L',
      isComprado: false
    ),
  ];
}