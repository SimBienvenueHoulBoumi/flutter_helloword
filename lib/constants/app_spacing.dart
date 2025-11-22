// ==========================================
// CONSTANTES : Espacements de l'application
// ==========================================
// 
// ✅ POURQUOI DES CONSTANTES ?
// - Code plus lisible et maintenable
// - Cohérence dans toute l'application
// - Facile à modifier globalement
//
// ==========================================

/// Espacements utilisés dans toute l'application
class AppSpacing {
  AppSpacing._(); // Constructeur privé pour empêcher l'instanciation

  // Espacements petits
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double small = 12.0;

  // Espacements moyens
  static const double md = 16.0;
  static const double medium = 20.0;
  static const double lg = 24.0;

  // Espacements grands
  static const double xl = 30.0;
  static const double xxl = 40.0;
  static const double large = 50.0;

  // Espacements très grands
  static const double huge = 60.0;
  static const double massive = 80.0;
}
