import 'package:flutter/material.dart';

class ListaComprasHome extends StatefulWidget {
  const ListaComprasHome({super.key, required this.title});
  final String title;
  @override
  State<ListaComprasHome> createState() => _ListaComprasHomeState();
}

class _ListaComprasHomeState extends State<ListaComprasHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Home Page')],
        ),
      ),
    );
  }
}
