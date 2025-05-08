import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_compras_mobile/configs/app_settings.dart';
import 'package:lista_compras_mobile/models/moeda.dart';
import 'package:lista_compras_mobile/repositories/favoritas_repository.dart';
import 'package:lista_compras_mobile/repositories/moeda_repository.dart';
import 'package:lista_compras_mobile/telas/cripto_moedas_detalhes.dart';
import 'package:provider/provider.dart';

class ListaCriptoMoedas extends StatefulWidget {
  const ListaCriptoMoedas({super.key, required this.title});
  final String title;
  @override
  State<ListaCriptoMoedas> createState() => _ListaCriptoMoedasState();
}

class _ListaCriptoMoedasState extends State<ListaCriptoMoedas> {
  Color color = Colors.blue;
  final tabela = MoedaRepository.tabela;
  //NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late NumberFormat real;
  late Map<String, dynamic> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final texto = loc['locale'] == 'pt_BR' ? 'Dolar (\$)' : 'Real (R\$)';
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.swap_vert),
              title: Text('Trocar para $texto'),
              onTap: () {
                context.read<AppSettings>().setLocale(locale, name);
                Navigator.pop(context);
              },
            )),
      ],
    );
  }

  appBarDinamica() {
    color = Theme.of(context).colorScheme.primary;
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: color,
        title: Text(widget.title),
        actions: <Widget>[
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          onPressed: limparSelecionadas,
          icon: Icon(Icons.cancel_outlined),
        ),
        backgroundColor: color.withValues(alpha: 0.6),
        title: Text('${selecionadas.length} Selecionados'),
        elevation: 1,
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CriptoMoedasDetalhes(moeda: moeda, color: color),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas.clear();
      //selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading:
                (selecionadas.contains(tabela[moeda]))
                    ? CircleAvatar(
                      backgroundColor: color.withValues(alpha: 0.2),
                      child: Icon(Icons.check),
                    )
                    : SizedBox(
                      width: 40,
                      child: Image.asset(tabela[moeda].icone),
                    ),
            title: Row(
              children: [
                if (favoritas.lista
                    .any((fav) => fav.sigla == tabela[moeda].sigla))
                  Icon(Icons.favorite, color: color, size: 20),
                Text(
                  tabela[moeda].nome,
                  style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Text(
              real.format(tabela[moeda].valor),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.grey[200],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          selecionadas.isNotEmpty
              ? FloatingActionButton.extended(
                onPressed: () {
                  favoritas.saveAll(selecionadas);
                  limparSelecionadas();
                },
                icon: Icon(Icons.favorite),
                backgroundColor: color,
                label: Text(
                  'FAVORITAR',
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : null,
    );
  }
}
