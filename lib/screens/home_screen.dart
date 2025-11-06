import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/content_card.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  // Remoção do 'const' para permitir a lista final (embora a lista seja constante, o widget pai não é)
  const HomeScreen({super.key}); 

  // Lista de conteúdo constante
  final List<ContentItem> _contentItems = const [
     ContentItem(
      tag: 'Chef',
      title: 'Risoto de Trufa Branca',
      subtitle: 'Nova criação do Chef Giovanni com trufas importadas da Itália. Uma experiência única de sabores refinados.',
      imageUrl: 'RISOTO DE TRUFA',
      icon: Icons.dining,
    ),
     ContentItem(
      tag: 'Em Breve',
      title: 'Noite de Jazz & Wins',
      subtitle: 'Sexta 15/11 às 20h - Música ao vivo com o quarteto Maria Schneider e harmonização especial de vinhos. Reserve sua mesa!',
      imageUrl: 'JAZZ & VINHOS',
      icon: Icons.calendar_month,
    ),
     ContentItem(
      tag: 'Exclusivo',
      title: 'Happy Hour Exclusivo',
      subtitle: 'Terça e Quinta das 17h às 19h - 20% off em drinks selecionados para membros do app!',
      imageUrl: 'HAPPY HOUR',
      icon: Icons.local_offer,
    ),
     ContentItem(
      tag: 'Menu',
      title: 'Novo Menu Degustação',
      subtitle: 'Confira as 5 etapas do novo menu, harmonizando pratos clássicos com tendências da gastronomia moderna.',
      imageUrl: 'MENU DEGUSTAÇÃO',
      icon: Icons.menu_book,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Consumer: Acessa o UserProvider para obter o nome dinamicamente
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final String userName = userProvider.user.name;
        
        return CustomScrollView(
          slivers: <Widget>[
            // --- 1. App Bar/Header ---
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                title: _buildWelcomeHeader(context, userName), 
                background: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Simulação da Logomarca (requer imagem em assets/images/begin_logo.png)
                      Image.asset( 
                        'assets/images/begin_logo.png', // Aponte para sua imagem
                        height: 40, 
                      ),
                      // Ícones de Perfil (Mock, para simplificar a remoção dos avatares de letras)
                      const Row(
                        children: [
                          Icon(Icons.notifications, color: Colors.white, size: 28),
                          SizedBox(width: 12),
                          CircleAvatar(
                            radius: 15, 
                            backgroundColor: Colors.purple, 
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- 2. Lista de Conteúdo ---
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Novidades & Eventos',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_contentItems.length} novidades',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  // Mapeia a lista de itens para ContentCard
                  ..._contentItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ContentCard(item: item),
                    );
                  }),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, String userName) {
    String firstName = userName.split(' ')[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Bem-vindo(a) de volta,',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        Row(
          children: [
            Text(
              '$firstName! ',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('🥃', style: TextStyle(fontSize: 24)),
          ],
        ),
      ],
    );
  }
}