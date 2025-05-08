import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/telas/carteira_page.dart';
import 'package:lista_compras_mobile/telas/configuracoes_page.dart';
import 'package:lista_compras_mobile/telas/cripto_moedas_favoritas.dart';
import 'package:lista_compras_mobile/telas/lista_cripto_moedas.dart';

class CriptoMoedas extends StatefulWidget {
  const CriptoMoedas({super.key});
  @override
  State<CriptoMoedas> createState() => _CriptoMoedasState();
}

class _CriptoMoedasState extends State<CriptoMoedas> {
  int paginaAtual = 0;
  late PageController pc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          ListaCriptoMoedas(title: 'Cripto Moedas'),
          CriptoMoedasFavoritas(title: 'Criptos Favoritas'),
          CarteiraPage(title: 'Carteira'),
          ConfiguracoesPage(title: 'Configurações'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Cripto Moedas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Carteira',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        onTap: (pagina) {
          setState(() {
            paginaAtual = pagina;
            pc.animateToPage(
              pagina,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          });
        },
      ),
    );
  }
}
