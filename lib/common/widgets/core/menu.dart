import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var session = getContext('session');
    String name = session['firstname'] + " " + session['lastname'];

    return Drawer(
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(Colors.purple.value),
                  Color(Colors.blue.value),
                  Color(Colors.cyan.value),
                ],
              ),
            ),
            accountName: Text(name),
            accountEmail: Text(session['email'].toString()),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.memory(base64Decode(session['avatar'])),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              Get.toNamed("/Profile");
            },
            child: const ListTile(
              title: Text("Perfil"),
              leading: Icon(Icons.person),
            ),
          ),
          const Divider(
            height: 0.1,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              Get.toNamed("/Settings");
            },
            child: const ListTile(
              title: Text("Configuración"),
              leading: Icon(Icons.settings),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              Get.toNamed("/Home");
            },
            child: const ListTile(
              title: Text("Salir"),
              leading: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
    );
  }
}
