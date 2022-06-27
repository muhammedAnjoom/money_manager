import 'package:flutter/material.dart';
import 'package:money_app/model/category/category_model.dart';
import 'package:money_app/model/transtion/transaction_model.dart';
import 'package:money_app/screens/add_transition/screen_add_trasition.dart';
import 'package:money_app/screens/home/screen_home.dart';
import 'package:hive_flutter/adapters.dart';



Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

 if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if(!Hive.isAdapterRegistered(TransctionModelAdapter().typeId)){
    Hive.registerAdapter(TransctionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:  ScreenHome(),
      routes: {
        ScreenAddTranstion.routeName:(ctx) => const ScreenAddTranstion(),
      },
    );
  }
}

