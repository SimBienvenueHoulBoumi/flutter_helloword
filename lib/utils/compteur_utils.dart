// ==========================================
// UTILITAIRE : Fonctions utilitaires pour le compteur
// ==========================================
// 
// Centralise la logique métier réutilisable
// Évite la duplication de code
//
// ==========================================

import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import 'package:flutter/material.dart';

/// Utilitaires pour le compteur
class CompteurUtils {
  CompteurUtils._(); // Constructeur privé pour empêcher l'instanciation

  /// Obtient un message selon la valeur du compteur
  static String getMessage(int valeur) {
    if (valeur == 0) {
      return 'Appuyez sur + ou - pour commencer !';
    } else if (valeur == AppValues.compteurValeurSeuil) {
      return 'Félicitations ! Vous avez atteint ${AppValues.compteurValeurSeuil} ! 🎊';
    } else if (valeur > 0) {
      return 'Bravo ! Vous comptez en positif 🎉';
    } else {
      return 'Vous êtes dans les négatifs ⚠️';
    }
  }

  /// Obtient une couleur selon la valeur du compteur
  static Color getCouleur(int valeur) {
    if (valeur == 0) {
      return AppColors.compteurZero;
    } else if (valeur > 0) {
      return AppColors.compteurPositif;
    } else {
      return AppColors.compteurNegatif;
    }
  }

  /// Vérifie si une valeur peut être incrémentée
  static bool peutIncrementer(int valeur) {
    return valeur < AppValues.compteurMax;
  }

  /// Vérifie si une valeur peut être décrémentée
  static bool peutDecrementer(int valeur) {
    return valeur > AppValues.compteurMin;
  }
}
