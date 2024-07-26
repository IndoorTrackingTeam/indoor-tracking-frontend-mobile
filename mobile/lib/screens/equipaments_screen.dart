// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile/api/equipament_service.dart';
import 'package:mobile/widgets/bottom_navbar.dart';

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
                  return GestureDetector(
                    onTap: () =>
                        _showEquipamentDetails(context, equipaments[index]),
                    child: cardEquipament(context, equipaments[index]),
                  );
                },
              ),
      ),
      bottomNavigationBar: Navbar(context, widget._token, 0),
    );
  }
}

Widget cardEquipament(BuildContext context, dynamic equipament) {
  return Container(
    decoration: BoxDecoration(
        color: Color(0xFF298C4C), borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  "assets/images/equipament.png",
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                equipament['name'].toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF2F2F2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Sala 14 - Prótese".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFF2F2F2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFFF2F2F2),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textEquipament(String text) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D2D2D),
      ),
    ),
  );
}

void _showEquipamentDetails(BuildContext context, dynamic equipament) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Dados do Equipamento",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  textEquipament(equipament['name']),
                  textEquipament(equipament['maintenance'].toString()),
                  textEquipament(equipament['maintenance'].toString()),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Historico",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return textEquipament(
                          "equipamento",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
