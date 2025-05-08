import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lista_compras_mobile/configs/app_settings.dart';
import 'package:lista_compras_mobile/models/moeda.dart';
import 'package:lista_compras_mobile/repositories/conta_repository.dart';
import 'package:provider/provider.dart';

class CriptoMoedasDetalhes extends StatefulWidget {
  const CriptoMoedasDetalhes({
    super.key,
    required this.moeda,
    required this.color,
  });
  final Moeda moeda;
  final Color color;
  @override
  State<CriptoMoedasDetalhes> createState() => _CriptoMoedasDetalhesState();
}

class _CriptoMoedasDetalhesState extends State<CriptoMoedasDetalhes> {
  //NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late NumberFormat real;
  late String moeda;
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  late ContaRepository conta;

  readNumberFormat() {
    final loc = context.watch<AppSettings>().locale;
    moeda = loc['locale'] == 'pt_BR' ? 'R\$' : '\$';
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  comprar() async {
    if (_form.currentState!.validate()) {
      // Salvar a compra
      await conta.comprar(widget.moeda, double.parse(_valor.text));

      if (!mounted) return;
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra realizada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    conta = Provider.of<ContaRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 50, child: Image.asset(widget.moeda.icone)),
                  Container(width: 10),
                  Text(
                    real.format(widget.moeda.valor),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: widget.color,
                    ),
                  ),
                ],
              ),
            ),
            (quantidade > 0)
                ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$quantidade ${widget.moeda.sigla}',
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    ),
                  ),
                )
                : Container(margin: EdgeInsets.only(bottom: 24)),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefix: Text(
                    moeda,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  suffix: Icon(Icons.monetization_on_outlined),
                  labelStyle: TextStyle(color: widget.color),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < 50) {
                    return 'Compra mínima é R\$ 50,00';
                  } else if (double.parse(value) > conta.saldo) {
                    return 'Você não tem saldo suficiente';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade =
                        (value.isEmpty)
                            ? 0
                            : double.parse(value) / widget.moeda.valor;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: comprar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(fontSize: 20, letterSpacing: 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
