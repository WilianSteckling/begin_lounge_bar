import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Estado: O tema atual (começa com o tema Dark do Lounge Bar)
  ThemeMode _themeMode = ThemeMode.dark; 

  ThemeMode get themeMode => _themeMode;

  // Método para alternar o tema (light/dark)
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Avisa a todos os Widgets que dependem deste estado
  }

  // Define o tema Dark principal do Begin Lounge Bar
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.purple,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: Colors.amber, // Cor de destaque
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    // ... adicione outras customizações de texto e elementos
  );

  // Define um tema Light (caso o usuário queira mudar)
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple, // Pode ser mantido ou alterado para um azul/cinza
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Colors.deepOrange, // Destaque diferente para light
      // PRINCIPAL AJUSTE: Cores para texto e ícones no tema claro
      onPrimary: Colors.black, // Cor do texto sobre a cor primária
      onSecondary: Colors.black, // Cor do texto sobre a cor secundária
      onSurface: Colors.black, // Cor do texto padrão em superfícies
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white, // Cor do texto e ícones na AppBar
      iconTheme: IconThemeData(color: Colors.white), // Cor dos ícones na AppBar
    ),
    textTheme: const TextTheme( // Ajusta a cor de todo o texto padrão
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black), // Cor padrão para ícones
    // Adicione outras customizações se necessário para Cards, Botões, etc.
    cardColor: Colors.grey[100], // Cor de fundo para Cards
    dividerColor: Colors.grey[300], // Cor para divisores
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Cor do texto em botões elevados
        backgroundColor: Colors.purple, // Cor de fundo em botões elevados
      ),
    ),
  );
}