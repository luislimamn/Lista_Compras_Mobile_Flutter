import 'package:lista_compras_mobile/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/btc.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      valor: 463520.00
    ),
    Moeda(
      icone: 'images/eth.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      valor: 9183.00
    ),
    Moeda(
        icone: 'images/ltc.png',
        nome: 'Litcoin',
        sigla: 'LTC',
        valor: 416.33
    ),
    Moeda(
        icone: 'images/sol.png',
        nome: 'Solana',
        sigla: 'SOL',
        valor: 629.62
    ),
    Moeda(
        icone: 'images/xrp.png',
        nome: 'XRP',
        sigla: 'XRP',
        valor: 11.12
    ),
  ];
}