// ==========================================
// CONSTANTES : Styles de texte de l'application
// ==========================================
// 
// Centralise tous les styles de texte pour une cohérence visuelle
//
// ==========================================

import 'package:flutter/material.dart';

/// Styles de texte utilisés dans toute l'application
class AppTextStyles {
  AppTextStyles._(); // Constructeur privé pour empêcher l'instanciation

  // Tailles de police
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeHuge = 48.0;
  static const double fontSizeMassive = 80.0;

  // Styles de texte réutilisables
  static const TextStyle bodySmall = TextStyle(
    fontSize: fontSizeSmall,
    color: Colors.grey,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontSizeMedium,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: fontSizeLarge,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: fontSizeMassive,
    fontWeight: FontWeight.bold,
    fontFamily: 'monospace',
  );

  static const TextStyle italicGrey = TextStyle(
    fontSize: fontSizeMedium,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  );
}
