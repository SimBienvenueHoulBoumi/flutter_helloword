// ==========================================
// MODÈLE : Session de compteur (pour sauvegarder l'historique)
// ==========================================
// 
// Ce modèle représente une session de compteur,
// par exemple pour sauvegarder l'historique plus tard.
// 
// 🎯 EXEMPLE D'UTILISATION FUTURE :
// - Sauvegarder une session avec un nom
// - Enregistrer la date et l'heure
// - Stocker les valeurs importantes
//
// ==========================================

class SessionCompteur {
  final String id;
  final String? nom;
  final int valeurFinale;
  final DateTime dateDebut;
  final DateTime dateFin;
  final List<int>? valeursIntermediaires; // Pour garder un historique

  SessionCompteur({
    required this.id,
    this.nom,
    required this.valeurFinale,
    required this.dateDebut,
    required this.dateFin,
    this.valeursIntermediaires,
  });

  // Méthode pour calculer la durée de la session
  Duration get duree {
    return dateFin.difference(dateDebut);
  }

  // Méthode pour obtenir une durée formatée
  String get dureeFormatee {
    final duree = this.duree;
    final minutes = duree.inMinutes;
    final secondes = duree.inSeconds % 60;
    return '${minutes}m ${secondes}s';
  }

  // Méthode pour convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'valeurFinale': valeurFinale,
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin.toIso8601String(),
      'valeursIntermediaires': valeursIntermediaires,
    };
  }

  // Méthode pour créer depuis JSON
  factory SessionCompteur.fromJson(Map<String, dynamic> json) {
    return SessionCompteur(
      id: json['id'] as String,
      nom: json['nom'] as String?,
      valeurFinale: json['valeurFinale'] as int,
      dateDebut: DateTime.parse(json['dateDebut'] as String),
      dateFin: DateTime.parse(json['dateFin'] as String),
      valeursIntermediaires: json['valeursIntermediaires'] != null
          ? List<int>.from(json['valeursIntermediaires'] as List)
          : null,
    );
  }

  @override
  String toString() {
    return 'SessionCompteur(id: $id, nom: $nom, valeur: $valeurFinale)';
  }
}
