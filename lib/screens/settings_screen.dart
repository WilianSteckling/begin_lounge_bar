// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch: Usamos 'watch' para que este widget seja reconstruído quando o tema mudar
    final themeProvider = context.watch<ThemeProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // --- 1. Seção Aparência ---
            _buildSettingsSection(
              context,
              title: 'Aparência',
              children: [
                // Configuração para alternar o tema (Dark/Light)
                ListTile(
                  leading: Icon(
                    themeProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: const Text('Tema'),
                  subtitle: Text(
                    themeProvider.themeMode == ThemeMode.dark ? 'Modo Escuro (Lounge)' : 'Modo Claro',
                  ),
                  trailing: Switch(
                    value: themeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      // Chama o método no provider para alternar o tema
                      themeProvider.toggleTheme();
                    },
                    activeThumbColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),

            // --- 2. Seção Conta ---
            _buildSettingsSection(
              context,
              title: 'Conta',
              children: [
                _buildSettingsItem(
                  context,
                  icon: Icons.lock,
                  title: 'Alterar Senha',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.email,
                  title: 'Alterar Email',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sair',
                  isDestructive: true,
                  onTap: () {},
                ),
              ],
            ),

            // --- 3. Seção Informações ---
            _buildSettingsSection(
              context,
              title: 'Informações',
              children: [
                _buildSettingsItem(
                  context,
                  icon: Icons.info,
                  title: 'Sobre o App',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.gavel,
                  title: 'Termos de Serviço',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para criar as seções (Aparência, Conta, etc.)
  Widget _buildSettingsSection(BuildContext context, {required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary, // Cor de destaque para títulos de seção
              ),
            ),
          ),
          Card(
            color: Theme.of(context).cardColor.withAlpha((255 * 0.05).round()),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para criar itens de lista simples
  Widget _buildSettingsItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, bool isDestructive = false}) {
    final color = isDestructive ? Colors.redAccent : Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}