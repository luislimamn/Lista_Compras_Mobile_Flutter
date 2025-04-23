import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/repositories/favoritas_repository.dart';
import 'package:lista_compras_mobile/widgets/moeda_card.dart';
import 'package:provider/provider.dart';

class CriptoMoedasFavoritas extends StatefulWidget {
  const CriptoMoedasFavoritas({super.key, required this.title});
  final String title;
  @override
  State<CriptoMoedasFavoritas> createState() => _CriptoMoedasFavoritasState();
}

class _CriptoMoedasFavoritasState extends State<CriptoMoedasFavoritas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.indigo.withValues(alpha: 0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? ListTile(
              leading: Icon(Icons.star),
              title: Text('Ainda não há moedas favoritas'),
            )
                : ListView.builder(
              itemCount: favoritas.lista.length,
              itemBuilder: (_, index) {
                return MoedaCard(moeda: favoritas.lista[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
