// ==========================================
// UTILITAIRE : Formatage des dates
// ==========================================
// 
// Centralise le formatage des dates pour éviter la duplication
//
// ==========================================

/// Utilitaires pour formater les dates
class DateFormatter {
  DateFormatter._(); // Constructeur privé pour empêcher l'instanciation

  /// Formate un nombre avec un zéro devant si nécessaire (0-9 -> 00-09)
  static String _padNumber(int number) {
    return number < 10 ? '0$number' : '$number';
  }

  /// Formate une date en format court (JJ/MM/AAAA HH:MM:SS)
  static String formatDateCourte(DateTime date) {
    return '${_padNumber(date.day)}/'
        '${_padNumber(date.month)}/'
        '${date.year} '
        '${_padNumber(date.hour)}:'
        '${_padNumber(date.minute)}:'
        '${_padNumber(date.second)}';
  }

  /// Formate une date en format ISO court (sans millisecondes)
  static String formatDateISO(DateTime date) {
    return date.toIso8601String().substring(0, 19);
  }

  /// Formate une date pour l'affichage dans l'UI
  static String formatDateAffichage(DateTime date) {
    return formatDateISO(date).replaceAll('T', ' ').replaceAll('-', '/');
  }

  /// Formate une date nullable (retourne 'Non modifié' si null)
  static String formatDateNullable(DateTime? date) {
    if (date == null) return 'Non modifié';
    return formatDateAffichage(date);
  }
}