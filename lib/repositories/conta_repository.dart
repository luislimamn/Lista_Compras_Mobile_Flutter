import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/database/db.dart';
import 'package:lista_compras_mobile/models/historico.dart';
import 'package:lista_compras_mobile/models/moeda.dart';
import 'package:lista_compras_mobile/models/posicao.dart';
import 'package:lista_compras_mobile/repositories/moeda_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;
  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    for (var operacao in operacoes) {
      Moeda moeda = MoedaRepository.tabela.firstWhere(
            (m) => m.sigla == operacao['sigla'],
      );
      _historico.add(Historico(
        dataOperacao:
        DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
        tipoOperacao: operacao['tipo_operacao'],
        moeda: moeda,
        valor: operacao['valor'],
        quantidade: double.parse(operacao['quantidade']),
      ));
    }
    notifyListeners();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    for (var posicao in posicoes) {
      Moeda moeda = MoedaRepository.tabela.firstWhere(
            (m) => m.sigla == posicao['sigla'],
      );
      _carteira.add(Posicao(
        moeda: moeda,
        quantidade: double.parse(posicao['quantidade']),
      ));
    }
    notifyListeners();
  }

  comprar(Moeda moeda, double valor) async {
    db = await DB.instance.database;

    await db.transaction((txn) async {
      // Verificar se a moeda já foi comprada
      final posicaoMoeda = await txn.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [moeda.sigla],
      );
      // Se não tem a moeda ainda, insert
      if (posicaoMoeda.isEmpty) {
        await txn.insert('carteira', {
          'sigla': moeda.sigla,
          'moeda': moeda.nome,
          'quantidade': (valor / moeda.valor).toString()
        });
      } else {
        final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': ((valor / moeda.valor) + atual).toString()},
          where: 'sigla = ?',
          whereArgs: [moeda.sigla],
        );
      }

      // Inserir o histórico
      await txn.insert('historico', {
        'sigla': moeda.sigla,
        'moeda': moeda.nome,
        'quantidade': (valor / moeda.valor).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      await txn.update('conta', {'saldo': saldo - valor});
    });

    await _initRepository();
    notifyListeners();
  }
}
