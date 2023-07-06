import 'package:flutter/material.dart';
import 'pages/plants_list/plants_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantly',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PlantsListPage(),
    );
  }
}
