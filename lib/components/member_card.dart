// lib/components/member_card.dart

import 'package:flutter/material.dart';

class Member {
  final String name;
  final String username;
  final String company;
  final String bio;
  final String primarySector;
  final List<String> tags;
  final String imageUrl;

  Member({
    required this.name,
    required this.username,
    required this.company,
    required this.bio,
    required this.primarySector,
    required this.tags,
    required this.imageUrl,
  });
}

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({super.key, required this.member});

  // Widget auxiliar para as Tags (setores)
  Widget _buildTag(String tag, Color color, Color textColor) {
    return Container(
      margin: const EdgeInsets.only(right: 6.0, bottom: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration( // <--- O Container deve usar 'decoration'
        color: color.withAlpha((255 * 0.1).round()), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha((255 * 0.5).round()), width: 0.5),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cores fictícias para o setor principal (poderia ser dinâmico por tema)
    Color primaryColor = _getColorForSector(member.primarySector);
    Color textColor = primaryColor; // Usamos a mesma cor no texto e borda

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        color: Colors.white.withAlpha((255 * 0.05).round()),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Topo: Avatar, Nome, Setor Primário
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar (simulação)
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(member.imageUrl), // Usaria NetworkImage
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${member.username}',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          member.company,
                          style: const TextStyle(
                              color: Colors.white70, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  // Tag de Setor Primário
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      member.primarySector,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),

              // Bio
              Text(
                member.bio,
                style: const TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 12),

              // Tags
              Wrap(
                children: [
                  ...member.tags.map((tag) => _buildTag(tag, primaryColor, textColor)),
                  // O ícone "+1" (simulação de mais tags)
                  if (member.tags.length > 2) // Se houver mais tags, mostra o "+1"
                    _buildTag('+${member.tags.length - 2}', Colors.grey, Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Função auxiliar para dar cores diferentes aos setores (melhora a visualização)
Color _getColorForSector(String sector) {
  switch (sector) {
    case 'Tecnologia':
      return Colors.blue;
    case 'Marketing':
      return Colors.pink;
    case 'Finanças':
      return Colors.green;
    case 'Design':
      return Colors.purple;
    case 'Saúde':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}