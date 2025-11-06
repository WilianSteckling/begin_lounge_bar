import 'package:flutter/material.dart';

// Modelo de dados simples (usamos Mapas por simplicidade ou podemos usar uma class)
class ContentItem {
  final String tag;
  final String title;
  final String subtitle;
  final String imageUrl;
  final IconData icon;

  const ContentItem({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
  });
}

class ContentCard extends StatelessWidget {
  final ContentItem item;

  const ContentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Usamos o Card para dar a elevação e bordas arredondadas do design
    return Card(
      color: Theme.of(context).cardColor.withAlpha((255 * 0.05).round()),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Imagem de Destaque
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Stack(
              children: [
                // Simulação da Imagem
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey.withAlpha((255 * 0.3).round()),
                  child: Center(
                    child: Text(
                      item.imageUrl, 
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                // Tag (Canto Superior Esquerdo)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      item.tag,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Detalhes do Conteúdo (Abaixo da Imagem)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(item.icon, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      item.tag, // Repetindo a tag aqui
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}