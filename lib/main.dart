import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/app_scaffold.dart';

void main() {
  runApp(const BeginLoungeBarApp());
}

class BeginLoungeBarApp extends StatelessWidget {
  const BeginLoungeBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider: Envolve o app para disponibilizar todos os estados
    return MultiProvider(
      providers: [
        // Provider para gerenciar o Tema (ThemeMode)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Provider para gerenciar os dados do Usuário (Nome, Fidelidade)
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      // Consumer: O Material App consome o ThemeProvider para mudança de tema
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Begin Lounge Bar',
            debugShowCheckedModeBanner: false,
            
            // Define o tema Dark e Light que criamos
            theme: ThemeProvider.lightTheme,
            darkTheme: ThemeProvider.darkTheme,
            themeMode: themeProvider.themeMode, // Controlado pelo estado!
            
            home: AppScaffold(), // Make sure AppScaffold is defined in app_scaffold.dart
          );
        },
      ),
    );
  }
}