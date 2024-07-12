// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile/api/equipamentService.dart';
import 'package:mobile/widgets/Navbar.dart';

class EquipamentsScreen extends StatefulWidget {
  final String _token;
  const EquipamentsScreen(this._token, {super.key});

  @override
  State<EquipamentsScreen> createState() => _EquipamentsScreenState();
}

class _EquipamentsScreenState extends State<EquipamentsScreen> {
  EquipamentService equipamentService = EquipamentService();
  List<dynamic> equipaments = [];
  bool isLoading = true;

  Future<void> _fetchEquipaments() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await equipamentService.getEquipaments();
    setState(() {
      equipaments = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEquipaments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: equipaments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(equipaments[index]['name']),
                  );
                },
              ),
      ),
      bottomNavigationBar: Navbar(context, widget._token, 0),
    );
  }
}
