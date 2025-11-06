// lib/screens/networking_screen.dart
import 'package:flutter/material.dart';
import '../components/member_card.dart';

class NetworkingScreen extends StatelessWidget {
  NetworkingScreen({super.key});

  // --- Dados Fictícios de Membros (Mock Data) ---
  final List<Member> _members = [
    Member(
      name: 'Carlos Silva',
      username: 'carlossilva',
      company: 'Tech Innovations Ltda',
      bio: 'Desenvolvedor Full Stack apaixonado por inovação. Adoro networking e trocar ideias sobre o futuro da IA.',
      primarySector: 'Tecnologia',
      tags: ['Tecnologia', 'Startups'],
      imageUrl: 'https://i.pravatar.cc/150?img=68',
    ),
    Member(
      name: 'Ana Paula Rocha',
      username: 'anapaularocha',
      company: 'Marketing Pro',
      bio: 'Especialista em Marketing Digital com 10 anos de experiência. Sempre em busca de novas parcerias e projetos.',
      primarySector: 'Marketing',
      tags: ['Marketing', 'Branding'],
      imageUrl: 'https://i.pravatar.cc/150?img=47',
    ),
    Member(
      name: 'Roberto Mendes',
      username: 'robertomendes',
      company: 'Finance Partners',
      bio: 'Consultor financeiro apaixonado por investimentos. Gosto de discutir sobre mercados emergentes e fintechs.',
      primarySector: 'Finanças',
      tags: ['Finanças', 'Investimento'],
      imageUrl: 'https://i.pravatar.cc/150?img=53',
    ),
    Member(
      name: 'Juliana Costa',
      username: 'jucostadesign',
      company: 'Creative Studio',
      bio: 'Designer UX/UI focada em criar experiências memoráveis. Amo conversar sobre design, arte e tecnologia.',
      primarySector: 'Design',
      tags: ['Design', 'UX/UI'],
      imageUrl: 'https://i.pravatar.cc/150?img=32',
    ),
    Member(
      name: 'Pedro Santos',
      username: 'pedrosantos',
      company: 'Startup Hub',
      bio: 'Empreendedor serial e mentor de startups. Adoro conectar pessoas e ideias para criar negócios de sucesso.',
      primarySector: 'Tecnologia',
      tags: ['Empreendedorismo', 'Startups'],
      imageUrl: 'https://i.pravatar.cc/150?img=11',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Networking'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // --- 1. Barra de Pesquisa e Filtro ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(child: _buildSearchBar(context)),
                const SizedBox(width: 10),
                _buildFilterButton(context),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- 2. Contagem de Membros ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${_members.length} membros encontrados',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),

          // --- 3. Lista de Membros ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _members.length,
              itemBuilder: (context, index) {
                return MemberCard(member: _members[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withAlpha((255 * 0.3).round())),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por nome, empresa ou setor...',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  
  Widget _buildFilterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withAlpha((255 * 0.05).round()),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withAlpha((255 * 0.3).round())),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list, color: Colors.grey),
          const SizedBox(width: 8),
          const Text('Todos os setores', style: TextStyle(color: Colors.grey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}