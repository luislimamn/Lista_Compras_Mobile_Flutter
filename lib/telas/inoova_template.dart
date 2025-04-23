import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/telas/cripto_moedas.dart';
import 'package:lista_compras_mobile/telas/lista_compras.dart';
import 'package:lista_compras_mobile/telas/my_home_page.dart';
import 'package:lista_compras_mobile/widgets/block_button.dart';

class InoovaTemplate extends StatefulWidget {
  const InoovaTemplate({super.key, required this.title});
  final String title;
  @override
  State<InoovaTemplate> createState() => _InoovaTemplateState();
}

class _InoovaTemplateState extends State<InoovaTemplate> {
  mostrarCriptoMoedas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CriptoMoedas()),
    );
  }

  mostrarListaCompras() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaCompras(title: 'Lista de Compras'),
      ),
    );
  }

  mostrarFlutterHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Flutter Home'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('images/inoovaLogo.png'),
            BlockButton(
              icon: Icons.monetization_on,
              label: 'Cotações Moedas',
              onPressed: mostrarCriptoMoedas,
            ),
            BlockButton(
              icon: Icons.monetization_on,
              label: 'Cotações Criptos',
              onPressed: mostrarCriptoMoedas,
            ),
            BlockButton(
              icon: Icons.shopping_cart,
              label: 'Lista de Compras',
              onPressed: mostrarListaCompras,
            ),
            BlockButton(
              icon: Icons.home,
              label: 'Flutter Home',
              onPressed: mostrarFlutterHome,
            ),
          ],
        ),
      ),
    );
  }
}
