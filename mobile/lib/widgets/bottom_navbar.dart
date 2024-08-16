// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:mobile/screens/equipaments_screen.dart';
import 'package:mobile/screens/settings_screen.dart';

Widget Navbar(BuildContext context, String token, int index) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20, left: 70, right: 70),
    padding: index == 0
        ? const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10)
        : const EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 10),
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF394170),
    ),
    child: index == 0
        ? Row(
            children: [
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EquipamentsScreen(token),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xFF2D2D2D)
                            : Color(0xFFFFFFFF),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assessment,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFFF5F7F8)
                                    : Color(0xFF394170),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Equipamentos',
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFFF5F7F8)
                                  : Color(0xFF394170),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Color(0xFFF5F7F8),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(token),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.assessment, color: Color(0xFFF2F2F2)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EquipamentsScreen(token),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(token),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF2D2D2D)
                          : Color(0xFFF5F7F8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFFF5F7F8)
                              : Color(0xFF394170),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Configurações',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFFF5F7F8)
                                    : Color(0xFF394170),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
  );
}
