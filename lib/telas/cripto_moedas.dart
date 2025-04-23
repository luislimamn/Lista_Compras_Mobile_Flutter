import 'package:flutter/material.dart';
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Cripto Moedas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritas',
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
