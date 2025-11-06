import 'package:flutter/material.dart';

// O número total de carimbos para completar a recompensa
const int _kTotalStamps = 20;

class LoyaltyStampGrid extends StatelessWidget {
  final int currentStamps; // Quantos carimbos o usuário já tem

  const LoyaltyStampGrid({
    super.key,
    required this.currentStamps,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Gerar a lista de widgets de carimbo
    List<Widget> stampWidgets = List.generate(_kTotalStamps, (index) {
      // Verifica se o carimbo atual (index + 1) já foi conquistado
      final bool isStamped = index < currentStamps;
      
      // Define a cor e o ícone com base no status
      final Color stampColor = isStamped
          ? Theme.of(context).colorScheme.secondary // Cor de carimbo completo
          : Theme.of(context).cardColor; // Cor de carimbo pendente (cinza claro no tema Dark)
      
      final IconData stampIcon = isStamped ? Icons.check : Icons.circle_outlined;

      return Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isStamped 
         ? stampColor // Cor total
         : stampColor.withAlpha((255 * 0.2).round()), // Opacidade para pendentes
          borderRadius: BorderRadius.circular(8.0), // Borda mais suave
        ),
        child: Center(
          child: isStamped
              ? Icon(
                  stampIcon,
                  color: Theme.of(context).scaffoldBackgroundColor, // Cor do ícone (fundo escuro)
                  size: 20,
                )
              : null, // Sem ícone para carimbos pendentes
        ),
      );
    });

    // 2. Usar GridView.count para organizar 4 colunas como na imagem
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((255 * 0.05).round()),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GridView.count(
        shrinkWrap: true, // Importante: Garante que o GridView use apenas o espaço necessário
        physics: const NeverScrollableScrollPhysics(), // Desativa a rolagem interna
        crossAxisCount: 4, // 4 Colunas, como na imagem
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0, // Quadrados
        children: stampWidgets,
      ),
    );
  }
}