import 'package:flutter/material.dart';

// Importa as telas principais
import 'home_screen.dart';
import 'loyalty_screen.dart';
import 'networking_screen.dart';
import 'profile_screen.dart';

class AppScaffold extends StatefulWidget { // <--- A classe precisa estar definida assim
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    HomeScreen(), // Dinâmico (sem 'const')
     LoyaltyScreen(),
     NetworkingScreen(),
     ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a tela atualmente selecionada
      body: _screens.elementAt(_selectedIndex),

      // Widget da Navegação Inferior
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Fidelidade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Networking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}