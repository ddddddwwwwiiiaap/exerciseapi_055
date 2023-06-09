import 'package:flutter/material.dart';
import 'package:materiapi/view/kategoriBarang/kategori_barang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ExerciseAPI',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const KategoriBarang(),
    );
  }
}