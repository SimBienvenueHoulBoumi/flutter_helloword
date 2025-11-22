// ==========================================
// CONSTANTES : Valeurs limites et règles métier
// ==========================================
// 
// Centralise les limites et valeurs importantes de l'application
//
// ==========================================

/// Valeurs et limites utilisées dans l'application
class AppValues {
  AppValues._(); // Constructeur privé pour empêcher l'instanciation

  // Limites du compteur
  static const int compteurMin = -1000;
  static const int compteurMax = 1000;

  // Valeurs spéciales
  static const int compteurValeurInitiale = 0;
  static const int compteurValeurSeuil = 10; // Seuil pour messages spéciaux

  // Configuration de l'application
  static const String appTitle = 'Mon Premier App Flutter';
  static const String appVersion = '1.0.0';
}
