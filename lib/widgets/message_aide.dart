import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../utils/compteur_utils.dart';

// ==========================================
// WIDGET RÉUTILISABLE : Message d'aide
// ==========================================
// 
// Ce widget affiche un message dynamique
// selon la valeur du compteur
// 
// ✅ AMÉLIORATIONS :
// - Utilise les constantes au lieu de magic numbers
// - Utilise CompteurUtils pour éviter la duplication
// - Accessibilité améliorée
//
// ==========================================

class MessageAide extends StatelessWidget {
  final int compteur;

  const MessageAide({
    super.key,
    required this.compteur,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Utilise CompteurUtils pour éviter la duplication
    final message = CompteurUtils.getMessage(compteur);

    return Semantics(
      // ✅ Accessibilité : Label pour les lecteurs d'écran
      label: message,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium), // ✅ Utilise la constante
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.italicGrey, // ✅ Utilise le style constant
        ),
      ),
    );
  }
}