import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/api.dart';
import 'package:lista_de_contatos/top_bar.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Lista de Contatos",
          style: TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          )
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        children: const <Widget>[TopBar()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
