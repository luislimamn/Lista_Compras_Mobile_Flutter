import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/repositories/produto_repository.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key, required this.title});
  final String title;
  @override
  State<ListaCompras> createState() => _ListaComprasTesteState();
}

class _ListaComprasTesteState extends State<ListaCompras> {
  late TextEditingController controller;
  final busca = ValueNotifier<String>('');
  Color color = Colors.blue;
  final tabela = ProdutoRepository.tabela;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: color,
        title: Text(widget.title),
        elevation: 0,
        actions: [
          IconButton(
            onPressed:
                () => setState(() {
                  color =
                      Colors.primaries[Random().nextInt(
                        Colors.primaries.length,
                      )];
                }),
            icon: Icon(Icons.color_lens),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(Icons.shopping_cart),
            ),
            title: Text(
              tabela[produto].nome,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              tabela[produto].quantidade,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        backgroundColor: color,
        child: const Icon(Icons.add),
      ),
    );
  }
}
