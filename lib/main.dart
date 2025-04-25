import 'package:flutter/material.dart';
import 'package:lista_compras_mobile/configs/app_settings.dart';
import 'package:lista_compras_mobile/configs/hive_config.dart';
import 'package:lista_compras_mobile/repositories/favoritas_repository.dart';
import 'package:lista_compras_mobile/telas/inoova_template.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inoova Flutter - Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      //home: const MyHomePage(title: 'Inoova Flutter Demo Home Page'),
      home: InoovaTemplate(title: 'Inoova Template Flutter'),
    );
  }
}
