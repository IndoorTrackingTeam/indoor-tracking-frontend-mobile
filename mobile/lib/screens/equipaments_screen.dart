// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
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
  final TextEditingController _searchController = TextEditingController();
  EquipamentService equipamentService = EquipamentService();
  List<dynamic> equipaments = [];
  List<dynamic> filteredEquipaments = [];
  bool isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchEquipaments();
    _timer = Timer.periodic(Duration(minutes: 2), (timer) {
      _fetchEquipaments();
    });
  }

  Future<void> _fetchEquipaments() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await equipamentService.getEquipaments();
    setState(() {
      equipaments = list;
      filteredEquipaments = list;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipamentos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchEquipaments,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredEquipaments = equipaments
                      .where((element) => element['name']
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search, color: Color(0xFF394170)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: isLoading
                  ? ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : filteredEquipaments.isEmpty
                      ? Center(
                          child: Text(
                            'Nenhum equipamento encontrado',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredEquipaments.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _getEquipamentsHistoric(
                                  context,
                                  equipamentService,
                                  filteredEquipaments[index]),
                              child: cardEquipament(
                                  context, filteredEquipaments[index]),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(context, widget._token, 0),
    );
  }
}

Widget cardEquipament(BuildContext context, dynamic equipament) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF394170),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
    ),
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
                child: equipament['image'] != null &&
                        equipament['image'].isNotEmpty
                    ? Image.memory(
                        base64Decode(equipament['image']),
                        width: 150,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "default.png",
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
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                equipament['name'].toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFF2F2F2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Sala ${equipament['c_room'].toUpperCase()}',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFF2F2F2),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget textEquipament(String text, BuildContext context) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF2D2D2D)
          : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? Color(0xFFF5F7F8)
            : Color(0xFF2D2D2D),
      ),
    ),
  );
}

Widget textEquipamentHistoric(String room, String date, BuildContext context) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF2D2D2D)
          : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              room,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFFF5F7F8)
                    : Color(0xFF2D2D2D),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> _getEquipamentsHistoric(BuildContext context,
    EquipamentService equipamentService, dynamic equipament) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(child: CircularProgressIndicator());
    },
  );
  
  Map<String, dynamic> data =
      await equipamentService.getOneEquipament(equipament['register']);
  Navigator.pop(context);
  _showEquipamentDetails(context, equipament, data);
}

void _showEquipamentDetails(
    BuildContext context, dynamic equipament, Map<String, dynamic> data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: screenSize.width * 0.8,
          height: 450,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF1D1D1D)
                : Color(0xFFF5F7F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 250,
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
                    textEquipament(equipament['name'].toUpperCase(), context),
                    textEquipament(equipament['register'].toString(), context),
                    textEquipament(
                        "Última vez visto na sala ${equipament['c_room']}",
                        context),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Histórico",
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
                        itemCount: (data['historic'] ?? []).length,
                        itemBuilder: (context, index) {
                          var initialDate = DateTime.parse(
                              data['historic'][index]['initial_date']);
                          var formattedDate = DateFormat('HH:mm dd/MM/yyyy')
                              .format(initialDate);
                          return textEquipamentHistoric(
                            'Sala ${data['historic'][index]['room']}',
                            formattedDate,
                            context,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
