import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/loyalty_stamp_grid.dart';
import '../providers/user_provider.dart';

// Definição constante para o total de carimbos
const int _kTotalStamps = 20;

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Usar Consumer para acessar os dados
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final int currentStamps = userProvider.currentStamps;
        // RESTAURADO: Usa o getter memberId do UserProvider
        final String memberId = userProvider.memberId; 
        final int visitsRemaining = _kTotalStamps - currentStamps;
        
        // Verifica se a recompensa foi alcançada
        final bool isMaxStamps = currentStamps >= _kTotalStamps;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Programa de Fidelidade'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // --- 1. Cabeçalho e Progresso ---
                _buildHeader(context, currentStamps, visitsRemaining),
                const SizedBox(height: 16),
                
                // --- 2. Grid de Carimbos (DINÂMICO) ---
                LoyaltyStampGrid(currentStamps: currentStamps),
                const SizedBox(height: 24),

                // --- NOVO: Botão de Ação / Teste ---
                _buildActionButton(context, userProvider, isMaxStamps),
                const SizedBox(height: 24),

                // --- 3. Recompensa Atual ---
                _buildRewardCard(context),
                const SizedBox(height: 32),
                
                // --- 4. QR Code e ID de Membro (DINÂMICO) ---
                _buildQRCodeSection(context, memberId),
                const SizedBox(height: 32),
                
                // --- 5. Outros Benefícios ---
                _buildBenefitsSection(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  // MÉTODO CORRIGIDO: Substitui OutlineButton.icon por OutlinedButton.icon
  Widget _buildActionButton(BuildContext context, UserProvider userProvider, bool isMaxStamps) {
    if (isMaxStamps) {
      return Center(
        // CORREÇÃO: OutlinedButton.icon
        child: OutlinedButton.icon(
          onPressed: () {
            // Simulação de resgate e reset
            userProvider.resetStamps();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recompensa resgatada! Cartão resetado.')),
            );
          },
          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
          label: const Text('RESGATAR RECOMPENSA (Resetar)', style: TextStyle(color: Colors.green)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      );
    }

    return Center(
      child: ElevatedButton.icon(
        // RESTAURADO: Chama o método do provider diretamente
        onPressed: userProvider.addStamp, 
        icon: const Icon(Icons.add_task, color: Colors.black),
        label: const Text('GANHAR NOVO CARIMBO (TESTE)', style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
      ),
    );
  }

  // --- Widgets de Construção (MÉTODOS AUXILIARES) ---
  
  Widget _buildHeader(BuildContext context, int currentStamps, int visitsRemaining) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Programa de Fidelidade',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cartão Digital',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.local_fire_department, size: 16, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 4),
            Text(
              'Você está quase lá! Mais $visitsRemaining visitas',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: currentStamps / _kTotalStamps,
          backgroundColor: Theme.of(context).cardColor.withAlpha((255 * 0.05).round()), 
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$currentStamps/$_kTotalStamps',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withAlpha((255 * 0.05).round()),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.card_giftcard, size: 30, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 16),
            const Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sua Recompensa',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Complete os 20 carimbos e ganhe um prato principal Grátis à sua escolha!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCodeSection(BuildContext context, String memberId) {
    return Column(
      children: [
        const Text(
          'Seu Código de Fidelidade',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Text(
          'Mostre este código ao finalizar seu pedido para ganhar carimbos',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Simulação do QR Code
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, size: 80, color: Colors.black),
                Text('QR Code Digital', style: TextStyle(color: Colors.black, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('ID do Membro', style: TextStyle(color: Colors.grey)),
        Text(memberId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Outros Benefícios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        _buildBenefitItem(
          context,
          icon: Icons.cake,
          title: 'Aniversário Especial',
          subtitle: 'Sobremesa grátis no seu dia',
        ),
        const SizedBox(height: 8),
        _buildBenefitItem(
          context,
          icon: Icons.star,
          title: 'Acesso Antecipado',
          subtitle: 'Reservas prioritárias para eventos',
        ),
      ],
    );
  }

  Widget _buildBenefitItem(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Card(
      color: Theme.of(context).cardColor.withAlpha((255 * 0.03).round()),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
