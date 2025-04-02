import 'package:esp32_bluetooth_project/feature/view/home/home_view.dart';
import 'package:esp32_bluetooth_project/product/constants/lang/local_keys_tr.dart';
import 'package:esp32_bluetooth_project/product/initializer/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  DependencyInjection.initializeDependencies();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocalKeysTr.MY_SMART_DEVICS,
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
