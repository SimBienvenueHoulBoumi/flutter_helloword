import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

// ==========================================
// WIDGET RÉUTILISABLE : Boutons de contrôle
// ==========================================
// 
// Ce widget contient tous les boutons de contrôle
// Il prend les fonctions en paramètres (callbacks)
// 
// ✅ AMÉLIORATIONS :
// - Utilise les constantes au lieu de magic numbers
// - Accessibilité améliorée
// - Labels sémantiques pour les lecteurs d'écran
//
// ==========================================

class BoutonsControle extends StatelessWidget {
  final VoidCallback onIncrementer;
  final VoidCallback onDecrementer;
  final VoidCallback onReinitialiser;
  final int compteur; // Pour désactiver certains boutons si besoin

  const BoutonsControle({
    super.key,
    required this.onIncrementer,
    required this.onDecrementer,
    required this.onReinitialiser,
    required this.compteur,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Bouton "-" (diminuer)
        Semantics(
          label: 'Diminuer le compteur',
          button: true,
          child: FloatingActionButton(
            onPressed: onDecrementer,
            backgroundColor: AppColors.buttonDecrement, // ✅ Utilise la constante
            heroTag: "decrement", // Nécessaire pour plusieurs FAB
            child: const Icon(Icons.remove),
          ),
        ),
        
        const SizedBox(width: AppSpacing.medium), // ✅ Utilise la constante
        
        // Bouton "Reset" (remettre à zéro)
        Semantics(
          label: 'Remettre le compteur à zéro',
          button: true,
          child: FloatingActionButton(
            onPressed: onReinitialiser,
            backgroundColor: AppColors.buttonReset, // ✅ Utilise la constante
            heroTag: "reset",
            child: const Icon(Icons.refresh),
          ),
        ),
        
        const SizedBox(width: AppSpacing.medium), // ✅ Utilise la constante
        
        // Bouton "+" (augmenter)
        Semantics(
          label: 'Augmenter le compteur',
          button: true,
          child: FloatingActionButton(
            onPressed: onIncrementer,
            backgroundColor: AppColors.buttonIncrement, // ✅ Utilise la constante
            heroTag: "increment",
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}