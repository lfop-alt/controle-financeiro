import 'package:fii_finance/src/pages/calcular_dy.dart';
import 'package:fii_finance/src/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[850]),
            accountName: const Text("Administrador"),
            accountEmail: const Text("Admin"),
            currentAccountPicture: Image.network(
                "https://cdn.pixabay.com/photo/2016/11/11/10/45/forex-1816365_1280.jpg"),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: const Text(
                "Pagina Inicial",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalcularDY(),
                  ));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: const Text(
                "Inserir",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
