// ==========================================
// CONSTANTES : Couleurs de l'application
// ==========================================
// 
// Centralise toutes les couleurs pour une cohérence visuelle
//
// ==========================================

import 'package:flutter/material.dart';

/// Couleurs utilisées dans toute l'application
class AppColors {
  AppColors._(); // Constructeur privé pour empêcher l'instanciation

  // Couleurs du compteur selon la valeur
  static const Color compteurZero = Colors.grey;
  static const Color compteurPositif = Colors.green;
  static const Color compteurNegatif = Colors.red;

  // Couleurs des boutons
  static const Color buttonIncrement = Colors.green;
  static const Color buttonDecrement = Colors.red;
  static const Color buttonReset = Colors.grey;
  static const Color buttonSave = Color(0xFF3742FA); // Bleu

  // Couleurs de base
  static const Color primary = Colors.deepPurple;
  static const Color background = Color(0xFF1A1A1A); // Fond sombre
  static const Color surface = Color(0xFF2D2D2D); // Surface sombre
}
