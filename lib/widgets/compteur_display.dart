import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../utils/compteur_utils.dart';

// ==========================================
// WIDGET RÉUTILISABLE : Affiche le compteur
// ==========================================
// 
// Ce widget est réutilisable : on peut l'utiliser partout !
// Il prend le compteur en paramètre et l'affiche avec style.
// 
// ✅ AMÉLIORATIONS :
// - Utilise les constantes au lieu de magic numbers
// - Utilise CompteurUtils pour la couleur
// - Accessibilité améliorée
//
// ==========================================

class CompteurDisplay extends StatelessWidget {
  final int compteur;
  
  const CompteurDisplay({
    super.key,
    required this.compteur,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // ✅ Accessibilité : Label sémantique pour les lecteurs d'écran
      label: 'Compteur: $compteur',
      value: '$compteur',
      child: Text(
        '$compteur',
        style: TextStyle(
          fontSize: AppTextStyles.fontSizeMassive, // ✅ Utilise la constante
          fontWeight: FontWeight.bold,
          fontFamily: AppTextStyles.headlineLarge.fontFamily,
          // ✅ Utilise CompteurUtils pour obtenir la couleur
          color: CompteurUtils.getCouleur(compteur),
        ),
      ),
    );
  }
}