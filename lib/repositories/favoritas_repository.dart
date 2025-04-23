import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/models/moeda.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Moeda> _lista = [];
  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);
  saveAll(List<Moeda> moedas) {
    for (var moedas in moedas) {
      if (!_lista.contains(moedas)) _lista.add(moedas);
    }
    notifyListeners();
  }

  remove(Moeda moeda) {
    _lista.remove(moeda);
    notifyListeners();
  }
}
